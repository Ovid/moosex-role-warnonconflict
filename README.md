# NAME

MooseX::Role::WarnOnConflict - Warn if classes override role methods without excluding them

# VERSION

version 0.01

# SYNOPSIS

This code will warn at composition time:

```perl
{
    package My::Role;
    use MooseX::Role::WarnOnConflict;
    sub conflict {}
}
{
    package My::Class;
    use Moose;
    with 'My::Role';
    sub conflict {}
}
```

With an error message similar to the following:

```
The class My::Class has implicitly overridden the method (conflict) from
role My::Role ...
```

To resolve this, explicitly exclude the 'conflict' method:

```perl
{
    package My::Class;
    use Moose;
    with 'My::Role' => { -excludes => [ 'conflict' ] };
    sub conflict {}
}
```

Aliasing a role method to an existing method will also warn:

```perl
{
    package My::Class;
    use Moose;
    with 'My::Role' => {
        -excludes => ['conflict'],
        -alias    => { conflict => 'another_method' },
    };
    sub conflict       { }
    sub another_method { }
}
```

# DESCRIPTION

When using [Moose::Role](https://metacpan.org/pod/Moose%3A%3ARole), a class which provides a method a role provides
will silently override that method.  This can cause strange, hard-to-debug
errors when the role's methods are not called.  Simply use
`MooseX::Role::WarnOnConflict` instead of `Moose::Role` and overriding a
role's method becomes a composition-time warning.  See the synopsis for a
resolution.

# AUTHOR

Curtis "Ovid" Poe <curtis.poe@gmail.com>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2022 by Curtis "Ovid" Poe.

This is free software, licensed under:

```
The Artistic License 2.0 (GPL Compatible)
```
