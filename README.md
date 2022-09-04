# Train::F5

A simple [Train](https://github.com/inspec/train) plugin that wraps REST calls to F5 BigIP load balancers.

Train is used by Chef infrastructure automation products like Chef Infra and Chef Inspec to connect to
remote backends.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'train-f5'
```

And then execute:

```bash
$ bundle install
```

Or just install it yourself as:

```bash
$ gem install train-f5
```

To test the plugin using Inspec you can try:-

```bash
inspec detect -t f5://admin:secrit_pa55word@f5.myorg.com:8443 --insecure
```

You should end up with output like this if all went well

```text
─────── Platform Details ───────

Name:      f5
Families:  api
Release:   16.1.3.1
```


## Usage in Inspec profiles

To write an Inspec custom resource, you can use the following methods:-

```ruby
json_body = inspec.backend.get(f5_rest_endpoint)
json_body = inspec.backend.put(f5_rest_endpoint, data)
json_body = inspec.backend.post(f5_rest_endpoint, data)
json_body = inspec.backend.delete(f5_rest_endpoint)
```

You can experiment with the API using the Inspec Shell

```bash
inspec detect -t f5://admin:secrit_pa55word@f5.myorg.com:8443 --insecure

inspec.backend.get '/mgmt/tm/sys/version'
```

## Example Custom Resource

_The custom resource_

```ruby
# libraries/f5_software.rb
class F5Software < Inspec.resource(1)
  name "f5_software"

  def version
    body = inspec.backend.get('/mgmt/tm/sys/version')
    f5_release = body['entries'].values[0]['nestedStats']['entries']['Version']['description']
  end
end
```

_The Control_

```ruby
# controls/software.rb
control "Software - 1.1" do
  impact 0.7
  title "Version must be correct"

  describe f5_software do
    its('version') { should eq '16.1.3.0' }
  end
end
```

## Credentials

You can pass credentials at the command line

```bash
inspec detect -t f5://admin:secrit_pa55word@f5.myorg.com:8443 --insecure
```

You can also pass credentials in environment variables (useful to avoid creds on the command line)

```bash
export F5_PORT=8443
export F5_HOST=f5.myorg.com
export F5_PASSWORD=secrit_pa55word
export F5_USER=admin

inspec detect -t f5:// --insecure
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trickyearlobe/train-f5.
