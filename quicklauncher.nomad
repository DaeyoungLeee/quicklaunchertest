variable "image" {}

job "testapp2" {

  datacenters = ["dc1"]

  group "demo" {
    count = 1
    network {
      mode = "bridge"
      port "http" {
	static = 20941
        to = 80
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
        #image = var.image
	image = dae93827/uplus-web2-new
        ports = ["http"]
      }
    }
  }
}

