job demoapp {

  datacenters = ["dc1"]

  group "quick-launcher" {
    count = 1
    network {
      mode = "bridge"
      port "http" {
        static = 20213
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
      
      driver = "docker"

      config {
        image = "dae93827/uplus-web2-new"
        ports = ["http"]
      }
    }
  }
}

