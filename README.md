# rails-test-action
A github action for running rails tests.


## Usage

This action requires some minimal configuration before it can properly run tests, this involves:
  - Creating a database service to run alongside the workflow job
  - Checking out the repository using `actions/checkout`
  - Setting a ruby environment which matches your repository using `actions/setup-ruby`
  - Configuring a bundle cache to speed up subsequent workflow runs with `actions/cache` (Optional, but recommended)

Once the above is done the action can be run with

```yml
  - uses: syntaf/rails-test-action@v1
    with:
      - database_url: 'your-database-connection-url'
      - database_password: 'your-test-database-password'
```

Skip to the last step in the next section if you want to just view an example workflow file using this action, or checkout the [Examples]() section.

## Walkthrough: Creating a new workflow with rails-test-action

1. If you haven't yet, create your [workflow file](https://help.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow) in the `.github/workflows/`directory in the root of your repository. for this example the file is named `test.yml`

2. Add some initial workflow configuration. Below is one such configuration which triggers this workflow to run on pushes or pull requests to master.

    ```yml
    # .github/workflows/test.yml

    name: Test

    on:
      push:
        branches: [ master ]
      pull_request:
        branches: [ master ]

    jobs:
      # ...
    ```

3. Configure the database service that will be used during tests. In this example a postgres image is used, but see [Examples]() for other databases being used.

   ```yml
   # .github/workflows/test.yml

   # ...

    jobs:
      test:
        runs-on: ubuntu-latest
        services:
          db:
            image: postgres:11
            env:
              POSTGRES_USER: postgres
              POSTGRES_PASSWORD: dev
            ports:
              - 5432:5432
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5
      
        steps:
          # ...
   ```

   Make sure your `POSTGRES_USER` and `POSTGRES_PASSWORD` values match what you have in your `database.yml` file in your rails repository.

4. Checkout your repository and configure a ruby envoionment with `actions/setup-ruby@v1`. The ruby version here should match the version of ruby used in your repository.

    ```yml
    # .github/workflows/test.yml

    # ...

    jobs:
      test:
        runs-on: ubuntu-latest
        services:
          db:
            image: postgres:11
            env:
              POSTGRES_USER: postgres
              POST_GRES_PASSWORD: dev
            ports:
              - 5432:5432
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5
      
        steps:
          - uses: actions/checkout@v2
          - uses: actions/setup-ruby@v1
            with:
              ruby-version: '2.6'
          - #...
    ```

5. Finally, cache your bundle using `actions/cache` then run `syntaf/rails-test-action`. Below is the final example configuration used in the [example repository](https://github.com/Syntaf/rails-test-action-example)

    ```yml
    # .github/workflows/test.yml

    name: Test

    on:
      push:
        branches: [ master ]
      pull_request:
        branches: [ master ]

    jobs:
      test:
        runs-on: ubuntu-latest
        services:
          db:
            image: postgres:11
            env:
              POSTGRES_USER: postgres
              POST_GRES_PASSWORD: dev
            ports:
              - 5432:5432
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5
      
        steps:
          - uses: actions/checkout@v2
          - uses: actions/setup-ruby@v1
            with:
              ruby-version: '2.6'
          - uses: actions/cache@v1
            with:
              path: vendor/bundle
              key: ${{ runner.os }}-gem-${{ hashFiles('**/Gemfile.lock') }}
              restore-keys: |
                ${{ runner.os }}-gem-
          - name: Run Tests
            uses: syntaf/rails-test-action@v1
            with:
              database-url: 'postgres://postgres@db/rails_test_action_example_test'
              database-password: 'dev'
    ```

    The configuration you see for `actions/cache` ensures that on _successfull_ runs, the installed gems are cached to make subsequent runs considerably faster. `syntaf/rails-test-action` will by default install gems into `vendor/bundle`; that's why you see that path mentioned above.