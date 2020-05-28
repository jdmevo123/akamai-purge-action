# GitHub Action to Purge Akamai Cache  🗑️ 

> **⚠️ Note:** To use this action, you must have access to the [GitHub Actions](https://github.com/features/actions) feature. GitHub Actions are currently only available in public beta. You can [apply for the GitHub Actions beta here](https://github.com/features/actions/signup/).

This simple action calls the Akamai Api's to purge the cache of your website, which can be a helpful last step after deploying a new version.


## Usage

All sensitive variables should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) in the action's configuration.

### Authentication

Include an edgerc file in your root directory.

#### Environment Secrets

| Key | Value | Type |
| ------------- | ------------- | ------------- |
| `objects` | The objects you wish to purge. For example, `['11111','12345']`. | `secret` |
| `action` | The action you wish to use. Valid options are, `invalidate, delete` | `secret` |


### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Deploy my website
on: push

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:

    # Put steps here to build your site, deploy it to a service, etc.

    - name: Purge cache
     
```

### Purging specific files

### Purging via CP Code


## License

This project is distributed under the [MIT license](LICENSE.md).
