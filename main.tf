terraform {
    cloud {
        organization = "conrad_bohm_test"

        workspaces {
        name = "cyberduck_test"
        }
    }
}

provider "aws" {
    region = "eu-west-2"
}

provider "aws" {
    region = "eu-west-1"
    alias = "replica"
}