# Terraform vpn setup for AWS

[![Build Status](https://travis-ci.com/GabLeRoux/terraform-aws-vpn.svg?branch=master)](https://travis-ci.com/GabLeRoux/terraform-aws-vpn)

Create a vpn server on AWS in its own vpc using terraform

![graph](./graph.svg)

## Getting Started

### Requirements

* The amazing [`jq`](https://stedolan.github.io/jq/) command line
* The `awscli` configured with your [`aws profile`](https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html).

### Related documentation

* [Terraform documentation](https://www.terraform.io/docs/)
* [How to install terraform](https://www.terraform.io/intro/getting-started/install.html)
* [Setup awscli profile using env vars](https://www.terraform.io/docs/providers/aws/index.html#environment-variables)
* [Setup VPN clients](https://git.io/vpnclients)
* [VPN Important notes](https://git.io/vpnnotes)
* [The VPN Install script](https://git.io/vpnsetup)

### Set your secrets in dotenv files

```bash
cp .env.example .env
cp .env.vpn.example .env.vpn
```

Then edit `.env` and `.env.vpn` to fit your needs

### Load your aws profile

I like to use the following function to quickly load environment variables:

```bash
function loadenv() {
    export $(cat ${$1:-.env} | xargs)
}
loadenv
```

In our case, this will `export` the `AWS_PROFILE` to the one defined in `.env`. :+1:

### Init terraform

```bash
terraform init
```

### See what's going to be applied

```bash
terraform plan
```

### Apply the changes

```bash
terraform apply
```

Write `yes` in the prompt if you're fine with this. Wait a few minutes and that's it, configure your vpn client and you're good to go! :tada:. 

## Additional details

### FAQ and Considerations

#### How much does it cost?

It depends of your usage. AWS offers a free tier and if you only use what's inside, it shouldn't cost you anything when using a `t2.micro` instance.

#### Should I stop the instance to save money?

If you're like me and have a bunch of instances running, you're passed the free tier so yes, stopping the instance will save you money when not using it. Caution tho, Elastic IPs are billed when attached to a stopped instance so you may want to detach it and delete it otherwise it will cost you 0.01$/h.

#### Can I use a variable to not use an Elastic IP?

Contributions are welcome :v:, without a variable, one can simply delete the `eip.tf` file and update `output.tf` and it should not create an Elastic IP for the instance anymore.

#### How much time does it take to provision all of this?

I don't have exact numbers, but it took me ~7 minutes to run including vpn script execution on the first time. Once this is done, there is no more delays.

#### How can I stop and start my instance from command line

```bash
export AWS_PROFILE=your_awesome_aws_profile
./scripts/vpn_stop.sh
./scripts/vpn_start.sh
./scripts/vpn_status.sh
```

The status script will display instance's public IP for convenience. Just run the script until it says soomething like that before you try to connect:

```json
[
  {
    "state": "running",
    "PublicIpAddress": "aaa.bbb.ccc.ddd",
    "PublicDnsName": "ec2-aaa-bbb-ccc-ddd.your-region-1.compute.amazonaws.com"
  }
]
```

:tada:

#### How much time does it take for the vpn to start when I start the instance?

A few seconds

#### Will the credentials be the same each time?

Yes, unless you've set empty values in `.env.vpn`, but creds are generated at provision (install) time.

#### Will I be invisible on the internets?

No, you're never invisible on the internets. Don't do bad things cuz Illuminatis are confirmed /o\ anyway. Glad you made it this far! :neckbeard: 

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)
