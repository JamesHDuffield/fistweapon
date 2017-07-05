# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    #-------------
    #- PIE CHART -
    #------------
    # Get context with jQuery - using jQuery's .get() method.
    classCounts = $('.chart_information').data('classcounts')
    classes = ['Warrior', 'Paladin', 'Hunter', 'Rogue', 'Priest', 'Death Knight', 'Shaman', 'Mage', 'Warlock', 'Monk', 'Druid', 'Demon Hunter']
    classColors = ['#C79C6E', '#F58CBA', '#ABD473', '#FFF569', '#FFFFFF', '#C41F3B', '#0070DE', '#69CCF0', '#9482C9', '#00FF96', '#FF7D0A', '#A330C9']
    pieChartCanvas = $('#pieChart').get(0).getContext('2d')
    PieData = {
        datasets: [{
            data: classCounts,
            backgroundColor: classColors,
            borderColor: '#222d32'
        }],
        labels: classes,
    }
    pieOptions = {
        type: 'doughnut',
        data: PieData,
        options: {
            maintainAspectRatio: false,
            layout: {
                padding: {
                    bottom: 10
                }
            }
            legend: {
                position: 'right'
            }
        }
    }
    pieChart = new Chart(pieChartCanvas, pieOptions)
