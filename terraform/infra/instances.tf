resource "yandex_compute_instance" "k8s_master" {
  name        = "k8s-master-1"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = true
  }

  metadata = {
    user-data = file("cloud-init.yaml")
  }
}

resource "yandex_compute_instance" "k8s_worker" {
  count       = 2
  name        = "k8s-worker-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = count.index == 0 ? "ru-central1-b" : "ru-central1-d"

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = count.index == 0 ? yandex_vpc_subnet.subnet_b.id : yandex_vpc_subnet.subnet_c.id
    nat       = true
  }

  metadata = {
    user-data = file("cloud-init.yaml")
  }
}

output "k8s_master_ip" {
  value = yandex_compute_instance.k8s_master.network_interface[0].nat_ip_address
}

output "k8s_worker_ips" {
  value = [for w in yandex_compute_instance.k8s_worker : w.network_interface[0].nat_ip_address]
}
