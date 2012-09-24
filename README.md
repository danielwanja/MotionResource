# MotionResource - A Framework to integrate an iOS RubyMotion app with Ruby on Rails

```
# WARNING: I just started this project (Sept 22nd 2012) at the Rocky Mountain Ruby Conf. I hope to expand it over the next couple of weeks. It's not ready even for experimenting yet. You have been warned! :-)
```

A RubyMotion Framework to integrate with Ruby on Rails. Provides Restful access to Rails including CRUD, nested resources, and nested attributes.

## RubyMotion App

Add the 'motion-resource' gem to your application.

## Declaring the Resources

First create a dynamic class that maps to a resource:

```ruby

  class Department
    include MotionResource::Resource
    columns :id => :integer, :name => :string, :city => :string, :state => :string    
  end

  class Employee
    include MotionResource::Resource

    columns :id => :integer
    columns :first_name, :last_name
    columns :job_id => :integer, :department_id => :integer, :manager_id => :integer
    columns :hire_date => :date
    columns :salary => :integer
  end

	
```

Note that by default MotionResource::Config.base_url points to http://localhost:3000. This works fine during development but you need to either point the resources to your server.

```ruby
  MotionResource::Config.base_url = "http://myresourceserver.com"
```

## Usage

### RubyMotion

The RubyMotion ActiveResource class allows to access a Rails resource and to perform a Index, Show, Create, Update and Delete. 

Find All:

```ruby
  Department.findAll() do |response|
    departments = response.body
  end
```

Find one:

```ruby
  Department.find(1) do |response|
  end
```

Create:

```ruby
    Department.create(:name => "Rocket Surgery") do |response|
    end
```

Update:

```ruby
    department.name = "New name"
    department.save() do |response|
    end
```
		
Delete:

```ruby
    department.delete() do |response|
    end
```

### Rails



### Community

Want to help? Contact Daniel Wanja d@n-so.com or send a pull request.

Enjoy!
Daniel Wanja

