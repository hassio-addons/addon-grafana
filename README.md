# Community Hass.io Add-ons: Grafana

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE.md)

[![GitLab CI][gitlabci-shield]][gitlabci]
![Project Maintenance][maintenance-shield]
[![GitHub Activity][commits-shield]][commits]

[![Bountysource][bountysource-shield]][bountysource]
[![Discord][discord-shield]][discord]
[![Community Forum][forum-shield]][forum]

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

The open platform for beautiful analytics and monitoring.

![Grafana in the Home Assistant Frontend](images/screenshot.png)

## About

The analytics platform for all your metrics.

Grafana allows you to query, visualize, alert on and understand your metrics
no matter where they are stored. Create, explore, and share dashboards. Learn
about your Home Automation system using sexy and compelling graphs, and other
data visualizations.

Combine this add-on with the InfluxDB add-on to get insanely powerful
insights to your home.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. [Add our Hass.io add-ons repository][repository] to your Hass.io instance.
1. Install the "Grafana" add-on.
1. Start the "Grafana" add-on.
1. Check the logs of the "Grafana" to see if everything went well.
1. Open the Web UI and log in with: admin / hassio.
   Be sure to change the logins, once logged in.

**NOTE**: Do not add this repository to Hass.io, please use:
`https://github.com/hassio-addons/repository`.

## Docker status

[![Docker Architecture][armhf-arch-shield]][armhf-dockerhub]
[![Docker Version][armhf-version-shield]][armhf-microbadger]
[![Docker Layers][armhf-layers-shield]][armhf-microbadger]
[![Docker Pulls][armhf-pulls-shield]][armhf-dockerhub]

[![Docker Architecture][aarch64-arch-shield]][aarch64-dockerhub]
[![Docker Version][aarch64-version-shield]][aarch64-microbadger]
[![Docker Layers][aarch64-layers-shield]][aarch64-microbadger]
[![Docker Pulls][aarch64-pulls-shield]][aarch64-dockerhub]

[![Docker Architecture][amd64-arch-shield]][amd64-dockerhub]
[![Docker Version][amd64-version-shield]][amd64-microbadger]
[![Docker Layers][amd64-layers-shield]][amd64-microbadger]
[![Docker Pulls][amd64-pulls-shield]][amd64-dockerhub]

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```json
{
  "log_level": "info",
  "ssl": true,
  "certfile": "fullchain.pem",
  "keyfile": "privkey.pem",
  "plugins": [
    "ayoungprogrammer-finance-datasource",
    "grafana-clock-panel"
  ],
  "env_vars": [
    {
      "name": "GF_DEFAULT_INSTANCE_NAME",
      "value": "Hassio"
    },
    {
      "name": "GF_ALLOW_SIGN_UP",
      "value": "true"
    }
  ]
}
```

**Note**: _This is just an example, don't copy and past it! Create your own!_

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

### Option: `ssl`

Enables/Disables SSL (HTTPS) on the web interface.
Set it `true` to enable it, `false` otherwise.

### Option: `certfile`

The certificate file to use for SSL.

**Note**: _The file MUST be stored in `/ssl/`, which is the default for Hass.io_

### Option: `keyfile`

The private key file to use for SSL.

**Note**: _The file MUST be stored in `/ssl/`, which is the default for Hass.io_

### Option: `plugins`

Allows you to specify additional Grafana plugins to be installed to your
Grafana setup. For a list of available plugins, see:

<https://grafana.com/plugins>

**Note**: _Adding plugins will result in a longer start-up for the add-on._

### Option: `env_vars`

This option allows you to tweak every aspect of Grafana by setting
configuration options using environment variables. See the example at the
start of this chapter to get an idea of how the configuration looks.

For more information about using these variables, see the official Grafana
documentation:

<http://docs.grafana.org/installation/configuration/#using-environment-variables>

**Note**: _Only environment variables starting with `GF_` are accepted._

## Using it with the InfluxDB Community add-on

Grafana does not come out of the box pre-configured, but letting it interact
with the community [InfluxDB add-on][influxdb-addon] is pretty easy. Please,
follow the instructions from the on how to [create a database][create-db]
for Home Assistant.

- Create a new user for Grafana on InfluxDB
  (InfluxDB Admin -> Users and "+ Create User")
- Login into Grafana
- Create a new datasource:
  - Name: Anything you want, e.g., Home Assistant
  - Type: InfluxDB
  - HTTP > URL: `http://a0d7b954-influxdb:8086`
  - HTTP > Access: Server (Default)
  - Auth: (leave them all disabled)
  - InfluxDB Details > Database: _Your Home Assistant InfluxDB database_
    e.g., `homeassistant`
  - InfluxDB Details > User: _Grafana InfluxDB username_
  - InfluxDB Details > Password: _Grafana InfluxDB user password_
- Hit Save & Test

Done!

## Embedding into Home Assistant

It is possible to embed the Grafana interface directly into Home Assistant,
allowing you to access it through the Home Assistant frontend.

Home Assistant provides the `panel_iframe` component, for these purposes.

Example configuration:

```yaml
panel_iframe:
  grafana:
    title: Grafana
    icon: mdi:chart-timeline
    url: http://addres.to.your.hass.io:3000
```

## Known issues and limitations

- This add-on does support ARM-based devices, nevertheless, they must
  at least be an ARMv7 device. (Raspberry Pi 1 and Zero is not supported).

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality. The format of the log is based on
[Keep a Changelog][keepchangelog].

Releases are based on [Semantic Versioning][semver], and use the format
of ``MAJOR.MINOR.PATCH``. In a nutshell, the version will be incremented
based on the following:

- ``MAJOR``: Incompatible or major changes.
- ``MINOR``: Backwards-compatible new features and enhancements.
- ``PATCH``: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- The Home Assistant [Community Forum][forum], we have a
  [dedicated topic][forum] on that forum regarding this add-on.
- The Home Assistant [Discord Chat Server][discord] for general Home Assistant
  discussions and questions.
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We have set up a separate document containing our
[contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## We have got some Hass.io add-ons for you

Want some more functionality to your Hass.io Home Assistant instance?

We have created multiple add-ons for Hass.io. For a full list, check out
our [GitHub Repository][repository].

## License

MIT License

Copyright (c) 2018 Franck Nijhof

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-anchore-shield]: https://anchore.io/service/badges/image/67d1185473090e99d5ac5e1bb4d1aa2295117a9bd3d7abbf8cd8a71e331c8388
[aarch64-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fgrafana-aarch64%3Alatest
[aarch64-arch-shield]: https://img.shields.io/badge/architecture-aarch64-blue.svg
[aarch64-dockerhub]: https://hub.docker.com/r/hassioaddons/grafana-aarch64
[aarch64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/grafana-aarch64.svg
[aarch64-microbadger]: https://microbadger.com/images/hassioaddons/grafana-aarch64
[aarch64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/grafana-aarch64.svg
[aarch64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/grafana-aarch64.svg
[amd64-anchore-shield]: https://anchore.io/service/badges/image/031c3ec49491c191e22395ba19981eaaabb892802c6698af08c92bfc8319cdc0
[amd64-anchore]: https://anchore.io/image/dockerhub/hassioaddons%2Fgrafana-amd64%3Alatest
[amd64-arch-shield]: https://img.shields.io/badge/architecture-amd64-blue.svg
[amd64-dockerhub]: https://hub.docker.com/r/hassioaddons/grafana-amd64
[amd64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/grafana-amd64.svg
[amd64-microbadger]: https://microbadger.com/images/hassioaddons/grafana-amd64
[amd64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/grafana-amd64.svg
[amd64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/grafana-amd64.svg
[armhf-anchore-shield]: https://anchore.io/service/badges/image/da56ee1d91a6b46756fcbf9d1bf2e90860a37ea992b57fa4627a8394b5fd239c
[armhf-anchore]: https://anchore.io/image/dockerhub/hassioaddons%grafana-armhf%3Alatest
[armhf-arch-shield]: https://img.shields.io/badge/architecture-armhf-blue.svg
[armhf-dockerhub]: https://hub.docker.com/r/hassioaddons/grafana-armhf
[armhf-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/grafana-armhf.svg
[armhf-microbadger]: https://microbadger.com/images/hassioaddons/grafana-armhf
[armhf-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/grafana-armhf.svg
[armhf-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/grafana-armhf.svg
[bountysource-shield]: https://img.shields.io/bountysource/team/hassio-addons/activity.svg
[bountysource]: https://www.bountysource.com/teams/hassio-addons/issues
[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg
[buymeacoffee]: https://www.buymeacoffee.com/frenck
[commits-shield]: https://img.shields.io/github/commit-activity/y/hassio-addons/addon-grafana.svg
[commits]: https://github.com/hassio-addons/addon-grafana/commits/master
[contributors]: https://github.com/hassio-addons/addon-grafana/graphs/contributors
[create-db]: https://github.com/hassio-addons/repository/addon-influxdb#integrating-into-home-assistant
[discord-shield]: https://img.shields.io/discord/330944238910963714.svg
[discord]: https://discord.gg/c5DvZ4e
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io/t/community-hass-io-add-on-grafana/54674?u=frenck
[frenck]: https://github.com/frenck
[gitlabci-shield]: https://gitlab.com/hassio-addons/addon-grafana/badges/master/pipeline.svg
[gitlabci]: https://gitlab.com/hassio-addons/addon-grafana/pipelines
[home-assistant]: https://home-assistant.io
[influxdb-addon]: https://github.com/hassio-addons/repository/addon-influxdb
[issue]: https://github.com/hassio-addons/addon-inflgrafanaxdb/issues
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[license-shield]: https://img.shields.io/github/license/hassio-addons/addon-grafana.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2018.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[reddit]: https://reddit.com/r/homeassistant
[releases-shield]: https://img.shields.io/github/release/hassio-addons/addon-grafana.svg
[releases]: https://github.com/hassio-addons/addon-grafana/releases
[repository]: https://github.com/hassio-addons/repository
[semver]: http://semver.org/spec/v2.0.0.htm
