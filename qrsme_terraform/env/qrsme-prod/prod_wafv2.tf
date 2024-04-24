module "prod_wafv2" {
  source      = "../../modules/wafv2"
  name_prefix = "prod-wafv2"
  alb_arn     = module.prod_api_alb.this_lb_arn

  #log_destination_configs = module.prod_delivery_stream.firehose_delivery_stream_arn
  resource_arn            = module.prod_wafv2.web_acl_arn
  

  scope = "REGIONAL"
  create_alb_association = true
  enabled = true
  allow_default_action = false # set to allow if not specified

  visibility_config = {
    metric_name = "prod-wafv2-main-metrics"
  }

rules = [
    {
      name     = "AWSManagedRulesAmazonIpReputationList-rule-1"
      priority = "1"

      override_action = "none" # set to none if not specified

      visibility_config = {
        metric_name                = "AWSManagedRulesAmazonIpReputationList-metric"
      }

      managed_rule_group_statement = {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    },
    {
      name     = "AWSManagedRulesCommonRuleSet-rule-2"
      priority = "2"

      override_action = "none" # set to none if not specified

      visibility_config = {
        metric_name                = "AWSManagedRulesCommonRuleSet-metric"
      }

      managed_rule_group_statement = {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
        excluded_rule = [
          "NoUserAgent_HEADER",
          "SizeRestrictions_BODY",
          "EC2MetaDataSSRF_BODY",
          "GenericLFI_QUERYARGUMENTS",
          "GenericRFI_QUERYARGUMENTS",
          "GenericRFI_BODY",
          "CrossSiteScripting_BODY"          
        ]
      }
    },
    {
      name     = "AWSManagedRulesKnownBadInputsRuleSet-rule-3"
      priority = "3"

      override_action = "none"

      visibility_config = {
        metric_name = "AWSManagedRulesKnownBadInputsRuleSet-metric"
      }

      managed_rule_group_statement = {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
  ]

regular_expressions_byte_match = [
    {
      name     = "Context-rule-1"
      priority = "4"

      visibility_config = {
        metric_name = "Context-rule1-metric"
      }

      byte_match_statement = {
        positional_constraint = "EXACTLY"
        search_string         = "/"
        priority = 0
        type = "NONE"
      }
    }
  ]

regular_expressions_regex_pattern_set = [
    {
      name     = "Context-rule-2"
      priority = "5"

      visibility_config = {
        metric_name = "Context-rule-2-metric"
      }

      regex_pattern_set_reference_statement = {
        arn = aws_wafv2_regex_pattern_set.prod_regex_pattern_set.arn
        priority = 0
        type = "NONE"
      }
    }
  ]



  

    business_tags = {
        BU = "ProductIT"
        CostCenter = "6465"
        Owner = "Perumal Varadharajulu"
        Email = "perumal.varadharajulu@hidglobal.com"
    }
    technical_tags = {
        Env = "PROD"
        Product = "Jenkins-as-a-Service"
        Terraform = "True"
    }
}