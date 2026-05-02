resource "aws_ecs_cluster" "task_3_49_cluster" {
  name = "task-3-49-cluster"
}

resource "aws_ecs_task_definition" "task_3_49_task" {
  family                   = "task-3-49-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "task-3-49-container"
      image     = "devan221/task-3-49-app:latest"
      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "task_3_49_service" {
  name            = "task-3-49-service"
  cluster         = aws_ecs_cluster.task_3_49_cluster.id
  task_definition = aws_ecs_task_definition.task_3_49_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.task_3_49_public_subnet.id]
    security_groups  = [aws_security_group.task_3_49_sg.id]
    assign_public_ip = true
  }
}