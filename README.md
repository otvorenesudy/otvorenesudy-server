# Open Courts Server

Provisioning roles and script for Open Courts servers.

## Deployment

### Development

First, try out deployment on localhost with Vagrant by uncommenting vagrant's `sysctl` settings in `site.yml`.

```
ansible-playbook -i hosts-development site.yml --ask-pass # Vagrant password is vagrant, usually.
```

### Production

Make sure, that you use correct `sysctl.kernel` attributes in `site.yml`. If you're not sure about `sysctl.kernel` attributes, just run `ansible-playbook -i hosts setup.yml`.

Run provision.


```
ansible-playbook -i hosts site.yml
```

## Contributing

1. Fork it
2. Create your feature branch `git checkout -b new-feature`
3. Commit your changes `git commit -am 'Add some feature'`
4. Push to the branch `git push origin new-feature`
5. Create new Pull Request

## License

[Educational Community License 1.0](http://opensource.org/licenses/ecl1.php)
