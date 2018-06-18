'''
The concept here is to simply take installed
generation and turn it into Capacity Factor it
should be a very simple calculation with some inputs
required.

The fomula used will be from UCDavis and follows
the basic:
(MW-h) / ((Days)*(24)*(Installed Capacity))

Longer range plan collect CalISO numbers and do
a monthly Capacity Factor. Then chart.
'''

hours = 24

def capacityfactor():
    '''
    Returns the capacity factor % of a power plant given the
    inputs of:
    :param ic (installed capacity): int.
    :param days (variable for now): int.
    :param output (actual power plant output): int.
    :return: float output / ((days)*(hours)(ic)).
    ''' 
    try:
        ic = input("Enter the installed capacity (16MW = 16): ")
        days = input("Enter the number of generation days (e.g. 30): ")
        output = input("Enter the output in MWh (e.g. 48,000MWh = 48000): ")
        ic = int(ic)
        days = int(days)
        global hours
        output = int(output)
        print('-----------------------------------------------')
        print("Installed Capacity is", ic,"MW")
        print("Number of days", days, "of generation")
        print("Hours per day", hours, "in a day")
        print("Output of power plant ", output, "MWh")
    except(ZeroDivisionError, ValueError):
        print('-----------------------------------------------')
        print("Invalid input.")
        print("-----------------------------------------------")
    cf = output / ((days)*(hours)*(ic))
    print("Capacity Factor is: "+"{0:.2%}".format(cf))

capacityfactor()
