# ruby-serverless

documentation: <https://documenter.getpostman.com/view/3827865/TzCQb6f3>

api url: <https://j3pm31hfpg.execute-api.ap-southeast-1.amazonaws.com/prod/>

## Requirement

- install ruby (v2.7)
- install gem
- install bundle
- install yarn
- install node (v14+)
- install serverless

## Testing and run

```zsh
// install ruby dependencies
$ bundle install

// install node dependencies
$ yarn

// test api in local
$ yarn run dev

// deploy to serverless
$ yarn run deploy

// open serverless dashboard
$ yarn run dashboard

// remove serverless services in aws (api gateway, lambda, s3, cloudformation)
$ yarn run remove

// rubocop
$ rubocop --auto-correct

// reek
$ reek
```
