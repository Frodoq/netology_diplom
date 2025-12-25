terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "y0__xC578YtGMHdEyCSuYS7E84cYoxoxg3tDhQJ9BGQFHVGNNIW"
  cloud_id  = "b1gbijb0r4nvpn1qpirs"
  folder_id = "b1gejj2e6dcoooha7og1"
  zone      = "ru-central1-a"
}

# Образ Ubuntu 22.04 LTS
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_network" "diplom_vpc" {
  name = "diplom-vpc"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "diplom-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom_vpc.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "diplom-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom_vpc.id
  v4_cidr_blocks = ["10.20.0.0/24"]
}

resource "yandex_vpc_subnet" "subnet_c" {
  name           = "diplom-subnet-c"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.diplom_vpc.id
  v4_cidr_blocks = ["10.30.0.0/24"]
}
