# Create AWS ALB Resource
resource "aws_lb" "alb" {
  name                       = "apps-alb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false # Set to true if you want deletion protection

  subnets         = [for subnet in aws_subnet.public_subnet : subnet.id]
  security_groups = [aws_security_group.allow_http_https_from_internet.id]

  enable_http2 = true
}

# Create target group for AWS ALB
resource "aws_lb_target_group" "alb_tg" {
  name        = "alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpc.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    protocol            = "HTTP"
    matcher             = "200-399"
  }
}

# Set to listen on port 80
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# Attach the EC2 to ALB
resource "aws_lb_target_group_attachment" "gw_alb_tg_attachment" {
  count            = length(var.private_subnets)
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.test_instances[count.index].id

  depends_on = [aws_instance.test_instances]
}