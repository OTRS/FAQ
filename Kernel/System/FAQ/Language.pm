# --
# Kernel/System/FAQ/Language.pm - faq language functions
# Copyright (C) 2001-2013 OTRS AG, http://otrs.org/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::FAQ::Language;

use strict;
use warnings;

=head1 NAME

Kernel::System::FAQ::Language - sub module of Kernel::System::FAQ

=head1 SYNOPSIS

All faq language functions.

=head1 PUBLIC INTERFACE

=over 4

=cut

=item LanguageAdd()

add a language

    my $Success = $FAQObject->LanguageAdd(
        Name   => 'Some Lanaguage',
        UserID => 1,
    );

Returns:

    $Success = 1;               # or undef if language could not be added

=cut

sub LanguageAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Name UserID)) {
        if ( !$Param{$Argument} ) {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    return if !$Self->{DBObject}->Do(
        SQL => '
            INSERT INTO faq_language (name)
            VALUES (?)',
        Bind => [ \$Param{Name} ],
    );

    return 1;
}

=item LanguageDelete()

Delete a language.

    my $DeleteSuccess = $FAQObject->LanguageDelete(
        LanguageID => 123,
        UserID      => 1,
    );

Returns

    $DeleteSuccess = 1;             # or undef if language could not be deleted

=cut

sub LanguageDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Attribute (qw(LanguageID UserID)) {
        if ( !$Param{$Attribute} ) {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );
            return;
        }
    }

    # delete the language
    return if !$Self->{DBObject}->Do(
        SQL => '
            DELETE FROM faq_language
            WHERE id = ?',
        Bind => [ \$Param{LanguageID} ],
    );

    return 1;
}

=item LanguageDuplicateCheck()

check a language

    my $Exists = $FAQObject->LanguageDuplicateCheck(
        Name       => 'Some Name',
        LanguageID => 1,        # for update
        UserID     => 1,
    );

Returns:

    $Exists = 1;                # if language already exists, or 0 if does not exist

=cut

sub LanguageDuplicateCheck {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "Need UserID!",
        );
        return;
    }

    # db quote
    $Param{Name} = $Self->{DBObject}->Quote( $Param{Name} ) || '';
    $Param{LanguageID} = $Self->{DBObject}->Quote( $Param{LanguageID}, 'Integer' );

    # build sql
    my $SQL = '
        SELECT id
        FROM faq_language
        WHERE';
    if ( defined $Param{Name} ) {
        $SQL .= " name = '$Param{Name}'";
    }
    if ( defined $Param{LanguageID} ) {
        $SQL .= " AND id != '$Param{LanguageID}'";
    }

    # prepare sql statement
    return if !$Self->{DBObject}->Prepare(
        SQL   => $SQL,
        Limit => 1,
    );

    # fetch the result
    my $Exists;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $Exists = 1;
    }

    return $Exists;
}

=item LanguageGet()

get a language details as a hash

    my %Language = $FAQObject->LanguageGet(
        LanguageID => 1,
        UserID     => 1,
    );

Returns:

    %Language = (
        LanguageID => '1',
        Name       => 'en',
    );

=cut

sub LanguageGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(LanguageID UserID)) {
        if ( !$Param{$Argument} ) {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # sql
    return if !$Self->{DBObject}->Prepare(
        SQL => '
            SELECT id, name
            FROM faq_language
            WHERE id = ?',
        Bind  => [ \$Param{LanguageID} ],
        Limit => 1,
    );

    my %Data;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        %Data = (
            LanguageID => $Row[0],
            Name       => $Row[1],
        );
    }

    return %Data;
}

=item LanguageList()

get the language list as a hash

    my %Languages = $FAQObject->LanguageList(
        UserID => 1,
    );

Returns:

    %Languages = (
        1 => 'en',
        2 => 'de',
        3 => 'es',
    );

=cut

sub LanguageList {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "Need UserID!",
        );
        return;
    }

    # build sql
    return if !$Self->{DBObject}->Prepare(
        SQL => '
            SELECT id, name
            FROM faq_language',
    );

    # fetch the result
    my %List;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $List{ $Row[0] } = $Row[1];
    }

    return %List;
}

=item LanguageLookup()

This method does a lookup for a faq language.
If a language id is given, it returns the name of the language.
If the name of the language is given, the language id is returned.

    my $LanguageName = $FAQObject->LanguageLookup(
        LanguageID => 1,
    );

    my $LanguageID = $FAQObject->LanguageLookup(
        Name => 'en',
    );

Returns:

    $LanguageName = 'en';

    $LanguageID = 1;

=cut

sub LanguageLookup {
    my ( $Self, %Param ) = @_;

    # check if both parameters are given
    if ( $Param{LanguageID} && $Param{Name} ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => 'Need LanguageID or Name - not both!',
        );
        return;
    }

    # check if both parameters are not given
    if ( !$Param{LanguageID} && !$Param{Name} ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => 'Need LanguageID or Name - none is given!',
        );
        return;
    }

    # check if LanguageID is a number
    if ( $Param{LanguageID} && $Param{LanguageID} !~ m{ \A \d+ \z }xms ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "LanguageID must be a number! (LanguageID: $Param{LanguageID})",
        );
        return;
    }

    # prepare SQL statements
    if ( $Param{LanguageID} ) {
        return if !$Self->{DBObject}->Prepare(
            SQL => '
                SELECT name
                FROM faq_language
                WHERE id = ?',
            Bind  => [ \$Param{LanguageID} ],
            Limit => 1,
        );
    }
    elsif ( $Param{Name} ) {
        return if !$Self->{DBObject}->Prepare(
            SQL => '
                SELECT id
                FROM faq_language
                WHERE name = ?',
            Bind  => [ \$Param{Name} ],
            Limit => 1,
        );
    }

    # fetch the result
    my $Lookup;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $Lookup = $Row[0];
    }

    return $Lookup;
}

=item LanguageUpdate()

update a language

    my $Success = $FAQObject->LanguageUpdate(
        LanguageID => 1,
        Name       => 'de',
        UserID     => 1,
    );

Returns:

    $Success = 1;               # or undef if language could not be updated

=cut

sub LanguageUpdate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(LanguageID Name UserID)) {
        if ( !$Param{$Argument} ) {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # build sql
    return if !$Self->{DBObject}->Do(
        SQL => '
            UPDATE faq_language
            SET name = ?
            WHERE id = ?',
        Bind => [ \$Param{Name}, \$Param{LanguageID} ],
    );

    return 1;
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (http://otrs.org/).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut
