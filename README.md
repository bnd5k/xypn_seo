# README

This Rails app evaluates the financial advisors listed at [http://www.xyplanningnetwork.com/consumer/find-advisor/](http://www.xyplanningnetwork.com/consumer/find-advisor/). 


response = RestClient.post 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php', {action: 'do_ajax_advisor_search', page: '1', amountPerPage: '10', filterCriteria: 'fee-structure', filterValue: 'all' }

