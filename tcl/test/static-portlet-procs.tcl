ad_library {
    Automated tests for the static-portlet package.

    @author Héctor Romojaro <hector.romojaro@gmail.com>
    @creation-date 2020-08-19
    @cvs-id $Id$
}

aa_register_case -procs {
        static_admin_portlet::link
        static_portlet::link
    } -cats {
        api
        production_safe
    } static_portlet_links {
        Test diverse link procs.
} {
    aa_equals "Static admin portlet link" "[static_admin_portlet::link]" ""
    aa_equals "Static portlet link"       "[static_portlet::link]" ""
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
