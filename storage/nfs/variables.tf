variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

# Choose an Availability Domain
variable "AD" {
    default = "1"
}

variable "InstanceShape" {
    default = "VM.Standard1.4"
}

variable "InstanceImageOCID" {
    type = "map"
    default = {
        // Oracle-provided image "Oracle-Linux-7.4-2017.12.18-0"
        // See https://docs.us-phoenix-1.oraclecloud.com/Content/Resources/Assets/OracleProvidedImageOCIDs.pdf
        us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaasc56hnpnx7swoyd2fw5gyvbn3kcdmqc2guiiuvnztl2erth62xnq"
        us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaxrqeombwty6jyqgk3fraczdd63bv66xgfsqka4ktr7c57awr3p5a"
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaayxmzu6n5hsntq4wlffpb4h6qh6z3uskpbm5v3v4egqlqvwicfbyq"
    }
}

variable "2TB" {
    default = "2097152"
}

variable "256GB" {
    default = "262144"
}

variable "BootStrapFile" {
    default = "./userdata/nfs-bootstrap"
}
