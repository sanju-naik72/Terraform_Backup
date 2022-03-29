/*---------------- create SNS ---------------------*/

resource "aws_sns_topic" "my-sns"{

			name = "my-sns"
}

/*         create sns cubscription           */


resource "aws_sns_topic_subscription" "my-sns-subscribe"{

			protocol = "email"
			endpoint = "sanjunaik72@gmail.com"
			topic_arn = aws_sns_topic.my-sns.arn

}
