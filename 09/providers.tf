terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.150"
    }
  }
}

provider "yandex" {
  cloud_id  = "b1ggq9ko35dqn8mj2oj1"
  folder_id = "b1g907dri4gbd19sfjip"
  zone      = "ru-central1-a"
}
