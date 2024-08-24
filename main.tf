terraform {
  required_providers {
    twc = {
        source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.4.4"
}

provider "twc" {
    token = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IjFrYnhacFJNQGJSI0tSbE1xS1lqIn0.eyJ1c2VyIjoiY3UyMDYzMCIsInR5cGUiOiJhcGlfa2V5IiwicG9ydGFsX3Rva2VuIjoiNjM5MmZlMTItY2U5YS00NmMyLWEyMmQtZDJhNmYzNDE2N2RhIiwiYXBpX2tleV9pZCI6IjlmYjJiZmE0LTQ0ZWItNGE3MS05YTM5LWRlZWQyMjlmZjNhNiIsImlhdCI6MTcyNDQ5ODQ0M30.w1s_3PgeWEGS3_AS1wNzdd0OJIjXimg8wxzviNSE2hQ_zfb4FxQS6HgRn0SUfq2hi6mCjVge_ghnj4RbS5Td_5wxFqMEp1fpZ3upL_NIJmr2kyFZPm1STIpSAOE9b4w-IQnWd8huz7ouGYBHtHQt9XECMDnBdtT5idvgqPUf6tmJmAX5IOZDUP59g2ycOAOtC3978Kjj-QFPP1ix9kvageP2C5CI1HPWMewzZ2gUrJ6QulEvFis7Pr4Dkt4neNEDPvfo9chAbH7kQKHH6R0aBLYnMDe1eVxguTofe6YOg7VM7P73BBB2mKkIFa6bBUDgwhzVTCVS08jDaKXiPykszDIwIHHc-LEfe_L78jVuSCFhaoiIPf04f1S9FLx1hXDXXe8O_BTZsbXkMqF10IhQk2Kv-QOmrsNCmzQa2J1CxkwJLd8H2DN9fn-UuQnZAc0qUFVZZW-EpNwU4Qn4XRhNSEf_6Df0JE-a9jjKFflUqm0-wlX0BifeEqtaphIioEx9"
}

data "twc_os" "os" {
    name = "ubuntu"
    version = "20.04"
}

data "twc_configurator" "configurator" {
  location = "kz-1"
}

resource "twc_server" "jenkins" {
  name = "Jenkins Server"
  os_id = data.twc_os.os.id
  ssh_keys_ids = [twc_ssh_key.your-key.id]
  
  configuration {
    configurator_id = data.twc_configurator.configurator.id
    disk = 51200
    cpu = 2
    ram = 1024 * 4
  }
}


resource "twc_server_ip" "ext_ip" {
    source_server_id = twc_server.jenkins.id
    type = "ipv4"
}

resource "twc_ssh_key" "your-key" {
  name = "Your key"
  body = file("~/.ssh/id_rsa.pub")
}