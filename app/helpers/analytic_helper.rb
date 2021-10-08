module AnalyticHelper
  def chart_bar_category(user)
    options = {
      colors:['#2f80ed'],
      chart: {   
        toolbar: {
          show: false,
          tools: {
            download: false,
          }
        }
      },  
      grid: {
        show: false
      },
      tooltip: {
        enabled: false
      },
      xaxis: {
        labels: {
          show: false,
          style: {
            fontSize: '20px'
          },
        },
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false,
        },
      },
      yaxis: {
        labels: {
          show: true,
          offsetY: 5,      
          style: {
            fontSize: '20px'
          },
        },
        axisBorder: {
          show: false,
        },
        axisTicks: {
          show: false
        }
      },
      plotOptions: {
        bar: {
          barHeight: '60%',
          dataLabels: {
            position: 'top',
            hideOverflowingLabels: true
          },          
        },
      },
      dataLabels: {
        enabled: true,
        style: {
            fontSize: '14px',
            colors: ["#304758"]
        }    
      } 
    }
    
    bar_chart(user.analytics_by_categories, options)
  end
end