# Mapnik Documentation

A home Mapnik-related documentation. This repository is mostly updated from other repositories, such as Node Mapnik when we trigger a rebuild of docs. 

### Triggering rebuilds

**Node Mapnik**

Builds are triggered via commit message codes. You commit message MUST include `[docs]` in order to rebuild docs in this repo. To change the version, in order to match `minor` semver, update the parameter in the [`.travis.yml`](https://github.com/mapnik/documentation/blob/88e3185396f7754eb937190dab737fe2b44d0e15/.travis.yml#L7).

Example commit message:

```
git commit -m 'adding new feature [docs]'
```

*All hail **mapnikbot**!*