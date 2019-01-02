# --
# Copyright (C) 2001-2019 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Modules::PublicFAQ;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # check needed objects
    for my $Object (qw(ParamObject DBObject LayoutObject LogObject ConfigObject )) {
        if ( !$Self->{$Object} ) {
            $Self->{LayoutObject}->CustomerFatalError( Message => "Got no $Object!" );
        }
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $Redirect = $ENV{REQUEST_URI};

    if ($Redirect) {
        $Redirect =~ s{PublicFAQ}{PublicFAQZoom}xms;
    }
    else {
        $Redirect = $Self->{LayoutObject}->{Baselink}
            . 'Action=PublicFAQZoom;ItemID='
            . $Self->{ParamObject}->GetParam( Param => 'ItemID' );
    }

    return $Self->{LayoutObject}->Redirect(
        OP => $Redirect,
    );
}

1;
