#!/usr/bin/env perl

use strict;
use warnings;
use JSON;

print encode_json({
	"provisioners" => [
		{
			type    => "shell",
			scripts => [
				"scripts/base.sh",
				"scripts/vagrant.sh",
				"scripts/virtualbox.sh",
				"scripts/cleanup.sh",
			],
			override => {
				virtualbox => {
					execute_command => "echo 'vagrant'|sudo -S sh '{{.Path}}'",
				},
			},
		},
	],
	"post-processors" => [{ type => "vagrant" }],
	"builders" => [
		{
			type                    => "virtualbox",
			boot_command            => ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"],
			boot_wait               => "10s",
			disk_size               => 40520,
			guest_os_type           => "RedHat_64",
			http_directory          => "http",
			iso_checksum            => "b37209879c0fb158fac25045527241ee",
			iso_checksum_type       => "md5",
			iso_url                 => "iso/CentOS-5.6-x86_64-bin-DVD-1of2.iso",
			ssh_username            => "vagrant",
			ssh_password            => "vagrant",
			ssh_port                => 22,
			ssh_wait_timeout        => "10000s",
			shutdown_command        => "echo '/sbin/halt -h -p' > /tmp/shutdown.sh; echo 'vagrant'|sudo -S sh '/tmp/shutdown.sh'",
			guest_additions_path    => "VBoxGuestAdditions_{{.Version}}.iso",
			virtualbox_version_file => ".vbox_version",
			vboxmanage => [
				[ "modifyvm", "{{.Name}}", "--memory", "512" ],
				[ "modifyvm", "{{.Name}}", "--cpus",     "1" ],
			],
		},
	],
});
