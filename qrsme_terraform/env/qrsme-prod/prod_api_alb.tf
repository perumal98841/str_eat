resource "random_pet" "api_this" {
  length = 2
}

#### Application Load Balancer ####
module "prod_api_alb" {
    source      = "../../modules/alb"

  name = "prod-api-alb"

  load_balancer_type = "application"

    vpc_id = module.prod_vpc.vpc_id
    security_groups              = module.prod_api_alb_sg.this_security_group_id
    subnets         = [module.prod_vpc.public_subnets[0],module.prod_vpc.public_subnets[1]]


  http_tcp_listeners = [
    # Forward action is default, either when defined or undefined
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "forward"
      target_group_arn = module.prod_api_alb.target_group_arns
#      action_type = "redirect"      
#      redirect = {
#        port        = "443"
#        protocol    = "HTTPS"
#        status_code = "HTTP_301"
#      }
    },
  ]

  target_groups = [
    {
      name_prefix          = "API"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 60
        path                = "/swagger"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }
      stickiness = {
        enabled         = true
        cookie_duration = 60
        type            = "lb_cookie"
    }      
      tags = {
        InstanceTargetGroupTag = "api"
      }
    },
  ]
}