# Two-Tier AWS Operations & Recovery Notes

These notes summarize the actual **Week 6 Assignment 3** exercise. They are not a copy of the EC2 user-data script (the source script was not supplied as a standalone file).

## Network and security verification

- VPC network: `10.0.0.0/16`, public and private subnets in two AZs.
- Public route: Internet Gateway; private outbound route: NAT Gateway.
- ALB group `ha-alb-sg`: HTTP 80 accessible publicly for the lab.
- EC2 group `ha-web-sg`: HTTP 80 from the **ALB SG**, SSH 22 limited to the administrator's current IP.
- RDS group `ha-db-sg`: database port accessible from the **EC2 SG**, not from the public internet.

## Linux app triage commands

```bash
sudo systemctl status apache2
sudo ss -tulpn
curl http://localhost
sudo tail -n 50 /var/log/apache2/error.log
sudo tail -n 50 /var/log/cloud-init-output.log
```

## Incidents handled in the lab

| Symptom | Reported cause | Lab resolution |
| --- | --- | --- |
| `httpd.service could not be found` | Amazon Linux package name used on Ubuntu | Install Ubuntu's `apache2` and PHP modules with `apt` |
| Apache default page, not PHP app | Default `index.html` takes precedence | Remove/rename the default file and use `index.php` |
| Bootstrap did not create app automatically | User-data partially failed | Manually rebuilt the page and adjusted user-data network waits/logging |
| App works via localhost but fails publicly | EC2 HTTP security-group rule missing | Add controlled HTTP access appropriate to the lab path |
| ALB target unhealthy | ALB-to-EC2 security group rule/target status issue | Verify HTTP 80 target, source SG and health checks |

## High-availability check

The reported ASG desired/min/max configuration was **2/2/4**. An instance was detached with the replacement option enabled, the target moved through draining, and the ALB website was checked during the exercise. This does **not** establish a complete multi-AZ disaster-recovery SLA.

## What is not present

The full original launch-template user-data Bash script was **not attached as source code**, so it is not fabricated here. The report uses inconsistent wording on whether ASG instances were placed in public or private subnets; verify before making a definitive subnet-placement claim.
