locals {
  # Common tags to be assigned to all resources
  common_tags = {
    environment         = "nonprod"
    infra-app           = "foundations"
    owner               = "david@argos-security.io"
  }
  name_prefix = "decentblog"
  location = "australiasoutheast"
}