package WWW::Yandex::CY;
use 5.008008;
use strict;
use warnings;
our $VERSION = '1.00';

# Preloaded methods go here.
use LWP::UserAgent;
my $lwp = LWP::UserAgent->new;


sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};
  $self->{SITE} = "http://jobs.su";
  bless($self, $class);
  return $self;
}


sub site {
  my $self = shift;
  if (@_) { $self->{SITE} = shift }
  return $self->{SITE};

}


sub print {
	my $self = shift;
	my $site = $self->site;


	#GET URL
	$lwp->timeout(30);
	$lwp->agent('Mozilla/4.0');
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

	use WWW::Yandex::CY;
	my $cy = WWW::Yandex::CY->new();
	$cy->site('http://jobs.su');
	my $get_cy = $cy->print();
	print $get_cy;


=head1 DESCRIPTION

The C<WWW::Yandex::CY> is a class implementing a interface for
querying Yandex Thematic Index of Citing (TIC) for domain.

=head1 AUTHOR

Kostya Ten F<E<lt>kostya@bk.ruE<gt>>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by http://www.jobs.su/ All Rights Reserved.

You may use, modify, and distribute this package under the
same terms as Perl itself.


=cut
