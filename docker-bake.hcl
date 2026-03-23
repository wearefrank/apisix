group "default" {
  targets = ["debian-dev", "ubuntu", "debian"]
}

target "docker-metadata-action" {}

target "frankgateway-base" {
  inherits = ["docker-metadata-action"]
  context = "."
  platforms = ["linux/amd64", "linux/arm64"]
  args = {
    ENABLE_PROXY = false
    CODE_PATH = "."
    ENTRYPOINT_PATH = "./docker-entrypoint.sh"
    INSTALL_BROTLI = "./install-brotli.sh"
  }
}

target "debian-dev" {
  inherits = ["frankgateway-base"]
  dockerfile = "./docker/debian-dev/Dockerfile"
}

target "ubuntu" {
  inherits = ["frankgateway-base"]
  dockerfile = "./docker/ubuntu/Dockerfile"
}

target "debian" {
  inherits = ["frankgateway-base"]
  dockerfile = "./docker/debian/Dockerfile"
}
