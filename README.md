[![Download](https://api.bintray.com/packages/jkellerer/fhem-smarter-coffee/fhem/images/download.svg) ](https://bintray.com/jkellerer/fhem-smarter-coffee/fhem/_latestVersion)

fhem-smarter-coffee
===================

Integrates a smarter coffee machine (http://smarter.am/) with the home automation server FHEM (http://fhem.de/fhem.html).

<img src="https://raw.githubusercontent.com/jkellerer/fhem-smarter-coffee/master/screenshot.png" width="794">

Usage
-----

### Installing the module

#### Option A: Via "update" in FHEM console

1. Execute the following command to add the latest version of the module once:
   ~~~
   update all https://dl.bintray.com/jkellerer/fhem-smarter-coffee/controls_smarter-coffee.txt
   ~~~
2. Execute the following command to add the module's source and receive automatic updates:
   ~~~
   update add https://dl.bintray.com/jkellerer/fhem-smarter-coffee/controls_smarter-coffee.txt
   ~~~

#### Option B: Via manual file copy

1. Copy [98_SmarterCoffee.pm](fhem/FHEM/98_SmarterCoffee.pm)
   into `/opt/fhem/FHEM/*` (the modules folder of your FHEM installation)

2. Optionally run `cd /opt/fhem && perl contrib/commandref_join.pl` to update your local command reference for getting information on how to use the module.

### Initializing / Enabling

1. Restart FHEM after installing or updating the module.
3. Execute the following command in the FHEM console and the module is **ready to use**:
   ~~~
   define coffee_machine SmarterCoffee
   ~~~

_Note_: The module has been tested with FHEM 5.7 (running on Linux) and smarter coffee firmware 22 (first version of SC).

Customization Examples
----------------------

### Automatic Hotplate Control

The following config snippet automates hotplate control by the use of the "cups_remaining" reading:

~~~ .perl
# Coffee machine
define coffee_machine SmarterCoffee
attr coffee_machine cups-per-carafe-removed 2

# BEGIN: Automatic hotplate logic ----

# Reheat when there are remaining cups
define coffee_machine_reheat_logic DOIF ([coffee_machine] eq "off")\
  (setreading coffee_machine cups_remaining 0)\
DOELSEIF ([coffee_machine] =~ "(brewing|grinding)" or [coffee_machine:carafe_required] eq "no")\
  ()\
DOELSEIF ([coffee_machine:hotplate] eq "off" and [coffee_machine:cups_remaining] > 0)\
  (set coffee_machine hotplate on-for-cups {(ReadingsNum("coffee_machine", "cups_remaining", 0))})\
DOELSEIF ([coffee_machine:cups_remaining] == 0)\
  (set coffee_machine hotplate off)
attr coffee_machine_reheat_logic do always

# Stop heating when carafe is removed for >=40 seconds
define coffee_machine_reheat_stop DOIF ([coffee_machine:carafe] eq "missing" and [coffee_machine:hotplate] eq "on")\
  (setreading coffee_machine cups_remaining 0)\
  (set coffee_machine hotplate off)
attr coffee_machine_reheat_stop wait 40

# Stop heating when hotplate is on for 75 minutes
define coffee_machine_reheat_max_time DOIF ([coffee_machine:cups_remaining] > 0)\
  (setreading coffee_machine cups_remaining 0)
attr coffee_machine_reheat_max_time wait 4500

# END: Automatic hotplate logic ----
~~~

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
