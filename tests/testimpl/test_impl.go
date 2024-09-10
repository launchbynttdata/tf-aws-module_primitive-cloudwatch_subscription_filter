package testimpl

import (
	"context"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs"
	awstypes "github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs/types"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestCloudwatchSubscriptionFilterComplete(t *testing.T, ctx types.TestContext) {
	logGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "cloudwatch_log_group_name")
	filterName := terraform.Output(t, ctx.TerratestTerraformOptions(), "cloudwatch_log_subscription_filter_name")
	filterDestinationArn := terraform.Output(t, ctx.TerratestTerraformOptions(), "cloudwatch_log_subscription_filter_destination_arn")
	firehoseDeliveryStreamArn := terraform.Output(t, ctx.TerratestTerraformOptions(), "firehose_delivery_stream_arn")
	cloudwatchlogsClient := GetAWSCloudwatchlogsClient(t)
	var filter awstypes.SubscriptionFilter

	t.Run("TestFilterExists", func(t *testing.T) {
		filters, err := cloudwatchlogsClient.DescribeSubscriptionFilters(context.TODO(), &cloudwatchlogs.DescribeSubscriptionFiltersInput{
			LogGroupName: &logGroupName,
		})
		assert.NoError(t, err)
		found := false
		for _, _filter := range filters.SubscriptionFilters {
			if *_filter.FilterName == filterName {
				filter = _filter
				found = true
				break
			}
		}
		assert.True(t, found, "Filter not found")
	})

	t.Run("TestFilterDestination", func(t *testing.T) {
		assert.NotEmpty(t, filter.DestinationArn)
		assert.Equal(t, filterDestinationArn, *filter.DestinationArn)
		assert.Equal(t, firehoseDeliveryStreamArn, *filter.DestinationArn)
	})
}

func GetAWSCloudwatchlogsClient(t *testing.T) *cloudwatchlogs.Client {
	client := cloudwatchlogs.NewFromConfig(GetAWSConfig(t))
	return client
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}
