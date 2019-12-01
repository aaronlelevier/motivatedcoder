# Readme

This is an example repo for learning Erlang

# Details

It currently consists of code for:

- cowboy - Erlang REST API 
- epgsql - PostreSQL client

# Build Project

```
$ rebar3 release && rebar3 shell
```

# Usage

Some code examples

## PostgreSQL

```
$ rebar3 shell
>1 pg:query("SELECT * from ec2_instance").
```

# License

MIT