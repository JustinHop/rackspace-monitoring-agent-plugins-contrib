# Rackspace Monitoring Agent Custom plugins

This repository contains contributed custom plugins for the Rackspace Cloud
Monitoring agent. For details about installing plugins, see [agent plugin check documentation](http://docs.rackspace.com/cm/api/v1.0/cm-devguide/content/appendix-check-types-agent.html#section-ct-agent.plugin).

These plugins were modified to include the hostname as part of the check, so you
can easily generate grafana graphs from the metrics.

## How to Contribute

You can contribute your plugins by first forking the repo, committing your changes, and then opening a pull request through github. If you have any questions, feel free to reach out to us on #cloudmonitoring on freenode IRC.

## Plugin Requirements

Each plugin must fulfill the following properties:

  * Output a status message to STDOUT
  * Output one or more metrics if it succeeds in obtaining them to STDOUT
  * Contain an appropriate license header
  * Contain example alarm criteria

## Status

The status message should be of the form <code>status $status_string</code>, For example, it might be:

<code>status ok succeeded in obtaining metrics</code>

or

<code> status err failed to obtain metrics</code>

The status string should be a summary of the results, with actionable information if it fails.

## Metrics

The metrics message should be of the form <code>metric $name $type $value [unit]</code>, for example:

<code>metric time int32 1 seconds</code>

The units are optional, and if present should be a string representing the units of the metric measurement. Units may not be provided on string metrics, and may not contain any spaces.

The available types are:

  * string
  * float
  * double
  * int32
  * int64
  * uint32
  * uint64
  * gauge

## Alarm Criteria

Each script should contain, just below the license header, in a comment, an example alarm criteria that can be used for the plugin. See the [Rackspace Cloud Monitoring Documentation](http://docs.rackspace.com/cm/api/v1.0/cm-devguide/content/alerts-language.html#concepts-alarms-alarm-language) for how to write alarm criteria.

## License Header

 The exact content will depend on your chosen license, but we recommend BSD, Apache 2.0, or MIT Licenses. Regardless of license choice the header should contain the author's (or authors') name(s) and email address(es).
