package WWW::Yandex::CY;
use 5.008008;
use strict;
use warnings;
our $VERSION = '1.10';

# Preloaded methods go here.
use LWP::UserAgent;
my $lwp = LWP::UserAgent->new;


sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};
  $self->{SITE} = "http://jobs.su";
  $self->{TIMEOUT} = "30";
  $self->{PROXY} = undef;
  $self->{AGENT} = "Grep Yandex CY 1.10";
  bless($self, $class);
  return $self;
}


sub site {
  my $self = shift;
  if (@_) { $self->{SITE} = shift }
  return $self->{SITE};
}


sub timeout {
  my $self = shift;
  if (@_) { $self->{TIMEOUT} = shift }
  return $self->{TIMEOUT};
}

sub proxy {
  my $self = shift;
  if (@_) { $self->{PROXY} = shift }
  return $self->{PROXY};
}

sub agent {
  my $self = shift;
  if (@_) { $self->{AGENT} = shift }
  return $self->{AGENT};
}

sub print {
	my $self = shift;
	my $site = $self->site;
	my $timeout = $self->timeout;
	my $proxy = $self->proxy;
	my $agent = $self->agent;

	#GET URL
	$lwp->timeout("$timeout");

	if ($proxy){
		$lwp->proxy(['http'], "http://djs:dfhevdfhev\@cache.xproxy.ru:3128");
	}

	$lwp->agent("$agent");

	my $response = $lwp->get( "http://bar-navig.yandex.ru/u?ver=2&url=$site&show=1&thc=0");

	my @result;
    if ($response->is_success) {
		my $result = $response->content;
    	push (@result, "$result");
    }
    else{
	    return $response->status_line;
    }


	my $result;
    foreach (@result) {
        if ($_ =~ m|(value="(\d+)"/>)|ig){
    		$result = "$2";
    	}
    }




	return $result;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

WWW::Yandex::CY - Yandex Thematic Index of Citing (TIC) for domain

=head1 SYNOPSIS

	# Default

    #!/usr/bin/perl
    use strict;
    use WWW::Yandex::CY;
	my $cy = WWW::Yandex::CY->new();
	$cy->site('http://jobs.su');
	my $get_cy = $cy->print();
	print $get_cy;


	# Obtaining through proxy

    #!/usr/bin/perl
    use strict;
    use WWW::Yandex::CY;
	my $cy = WWW::Yandex::CY->new();
	$cy->site('http://jobs.su');
	$cy->timeout('30');
	$cy->proxy('http://login:password\@server:port');
	$cy->agent('Mozilla/4.0');
	my $get_cy = $cy->print();
	print $get_cy;



=head1 DESCRIPTION

The C<WWW::Yandex::CY> is a class implementing a interface for
querying Yandex Thematic Index of Citing (TIC) for domain.

Obtaining domain value
$cy->site('http://domain.ru');

Timeout (value in seconds) Default = 30 seconds
$cy->timeout('30');

Proxy (Obtaining through proxy) Default = undef
$cy->proxy('http://login:password\@server:port');

User Agent Default = Grep Yandex CY 2.0
$cy->agent('Mozilla/4.0');

=head1 AUTHOR

Kostya Ten F<E<lt>kostya@bk.ruE<gt>>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by http://www.jobs.su/ All Rights Reserved.

You may use, modify, and distribute this package under the
same terms as Perl itself.


=cut
