package MooseX::Meta::Role::WarnOnConflict;

# ABSTRACT: metaclass for Moose::Meta::Role

use Moose;
extends 'Moose::Meta::Role';

our $VERSION = '0.01';

override apply => sub {
    my ( $self, $other, @args ) = @_;

    if ( blessed($other) && $other->isa('Moose::Meta::Class') ) {
        # already loaded
        return MooseX::Meta::Role::Application::ToClass::WarnOnConflig->new(@args)
          ->apply( $self, $other );
    }

    super;
};

1;

__END__

=head1 DESCRIPTION

This is the metaclass for C<MooseX::Role::WarnOnConflict>.  For internal use only.
