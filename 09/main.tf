locals {
  nodes = {
    k8s-master = {
      cores  = 2
      memory = 4
      ip     = "10.128.0.10"
    }
    k8s-worker-1 = {
      cores  = 2
      memory = 2
      ip     = "10.128.0.11"
    }
    k8s-worker-2 = {
      cores  = 2
      memory = 2
      ip     = "10.128.0.12"
    }
    k8s-worker-3 = {
      cores  = 2
      memory = 2
      ip     = "10.128.0.13"
    }
    k8s-worker-4 = {
      cores  = 2
      memory = 2
      ip     = "10.128.0.14"
    }
  }
}

resource "yandex_compute_instance" "k8s" {
  for_each = local.nodes

  name        = each.key
  hostname    = each.key
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = "fd84np9sg3hrgaoisfnj"
      type     = "network-hdd"
      size     = 20
    }
  }

  network_interface {
    subnet_id          = "e9bs31csr4jeeguflb5f"
    ip_address         = each.value.ip
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${trimspace(file(pathexpand("~/.ssh/id_ed25519.pub")))}"
  }
}
