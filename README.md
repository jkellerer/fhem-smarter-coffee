# fhem-smarter-coffee

Integrates a smarter coffee machine (http://smarter.am/) with the home automation server FHEM (http://fhem.de/fhem.html).

Usage
-----

1. Copy [98_SmarterCoffee.pm](fhem/FHEM/98_SmarterCoffee.pm)
   into `/opt/fhem/FHEM/*` (the modules folder of your FHEM installation)
2. Restart FHEM
3. Enter `define coffee-machine SmarterCoffee` in the FHEM console
   and the module is **ready**

Optionally run `cd /opt/fhem && perl contrib/commandref_join.pl` to update
the local command reference for more information on how to use the module.

The module has been tested with FHEM 5.7 (running on Linux) and smarter coffee firmware 22.

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature-or-fix`)
3. Commit your changes (`git commit -am 'Add some feature-or-fix'`)
4. Push to the branch (`git push origin my-new-feature-or-fix`)
5. Create new Pull Request

License
-------

GPLv2 (like FHEM), see [LICENSE](LICENSE)
