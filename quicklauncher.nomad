variable "image" {}
variable "static_port" {}
variable "to_port" {}
variable "job_id" {}

job "var.job_id" {

  datacenters = ["dc1"]

  group "quick-launcher" {
    count = 1
    network {
      mode = "bridge"
      port "http" {
	static = var.static_port
        to = var.to_port
      }
    }

    service {
      name = "demo-quicklauncher"
      port = "http"

      check {
        type     = "http"
        path     = "/"
        interval = "2s"
        timeout  = "2s"
      }
    }

    task "server" {
      env {
        PORT    = "${NOMAD_PORT_http}"
        NODE_IP = "${NOMAD_IP_http}"
      }

      driver = "docker"

      config {
        image = var.image
        ports = ["http"]
      }
    }
  }
}

