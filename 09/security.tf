resource "yandex_vpc_security_group" "k8s" {
  name        = "k8s-sg"
  description = "Security group for Kubernetes homework cluster"
  network_id  = "enptj5jb32o62tmvpgtc"

  ingress {
    protocol       = "TCP"
    description    = "SSH from administrator"
    v4_cidr_blocks = ["66.90.92.74/32"]
    port           = 22
  }

  ingress {
    protocol       = "ANY"
    description    = "Kubernetes internal communication"
    v4_cidr_blocks = ["10.128.0.0/24"]
    from_port      = 0
    to_port        = 65535
  }

  egress {
    protocol       = "ANY"
    description    = "Outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
