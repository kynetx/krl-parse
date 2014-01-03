krl-parse
=========

Simple command line tool to validate KRL.

Sample usage:

```krl-parse.pl -f a16x144.krl```

validates the KRL in the named file. 

```krl-parse.pl -?```

returns help message. 

Proudly crafted in Perl. 

Depends on 

	Getopt::Std;
	LWP::UserAgent;
	HTTP::Request;
	URI::Escape;
	JSON

If you do not have some of these packages and you're not a Perl person, you first need to [install cpanminus](http://cpanmin.us) by running the following command:

	curl -L http://cpanmin.us | perl - App::cpanminus

If you don't have curl but wget, replace `curl -L` with `wget -O -`.

Then you can use cpanm to install the missing dependencies as follows:

	cpanm -S JSON

