# Mapnik Documentation

A home Mapnik-related documentation. This repository is mostly updated from other repositories, such as Node Mapnik when we trigger a rebuild of docs.

### Building docs

**Node Mapnik**

Documentation is built daily (if changes exist) by TravisCI cron jobs. Changes are always pulled from the Node Mapnik `master` branch. Node Mapnik theme is located in the `_theme/` directory and is a fork of the DocumentationJS default theme.

If you need to generate documentation for Node Mapnik immediately (instead of waiting for the daily build) head to TravisCI and restart the `master` branch jobs.

##### *All hail **mapnikbot**!*