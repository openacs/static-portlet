ad_library {
    Automated tests for the static-portlet package.

    @author Héctor Romojaro <hector.romojaro@gmail.com>
    @creation-date 2020-08-19
    @cvs-id $Id$
}

aa_register_case -procs {
        static_admin_portlet::link
        static_portlet::link
        static_portlet::get_pretty_name
    } -cats {
        api
        production_safe
    } static_portlet_links_names {
        Test diverse link and name procs.
} {
    aa_equals "Static admin portlet link"   "[static_admin_portlet::link]" ""
    aa_equals "Static portlet link"         "[static_portlet::link]" ""
    aa_equals "Static portlet pretty name"  "[static_portlet::get_pretty_name]" ""
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
