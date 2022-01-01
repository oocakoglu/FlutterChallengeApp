import 'package:test/model/country.dart';
import 'package:test/model/cstate.dart';

class LocalData {
  static List<Country> getAllCountries() {
    List<Country> counties = <Country>[];
    counties.add(const Country("", "Select County"));
    counties.add(const Country("U.S.", "United States of America"));
    counties.add(const Country("CA.", "Canada"));
    return counties;
  }

  static List<CState> getStatesFromCounty(String countyCode) {
    List<CState> states = getAllStates();
    states = states.where((q) => q.countrycode == countyCode).toList();
    states.insert(0, const CState(0, "", "", "Select State"));
    return states;
  }

  static CState getState(String stateCode) {
    List<CState> st = getAllStates();
    if (st.where((q) => q.stateab == stateCode).isEmpty == false) {
      return st.where((q) => q.stateab == stateCode).first;
    } else {
      return const CState(-1, "", "", "No Registered State");
    }
  }

  static List<CState> getAllStates() {
    List<CState> states = <CState>[];
    states.add(const CState(0, "", "", "Select State"));
    states.add(const CState(1, "AL", "U.S.", "Alabama"));
    states.add(const CState(54, "AK", "U.S.", "Alaska"));
    states.add(const CState(2, "AZ", "U.S.", "Arizona"));
    states.add(const CState(3, "AR", "U.S.", "Arkansas"));
    states.add(const CState(4, "CA", "U.S.", "California"));
    states.add(const CState(5, "CO", "U.S.", "Colorado"));
    states.add(const CState(6, "CT", "U.S.", "Connecticut"));
    states.add(const CState(7, "DE", "U.S.", "Delaware"));
    states.add(const CState(8, "DC", "U.S.", "District of Columbia"));
    states.add(const CState(9, "FL", "U.S.", "Florida"));
    states.add(const CState(10, "GA", "U.S.", "Georgia"));
    states.add(const CState(52, "HI", "U.S.", "Hawaii"));
    states.add(const CState(11, "ID", "U.S.", "Idaho"));
    states.add(const CState(12, "IL", "U.S.", "Illinois"));
    states.add(const CState(13, "IN", "U.S.", "Indiana"));
    states.add(const CState(14, "IA", "U.S.", "Iowa"));
    states.add(const CState(15, "KS", "U.S.", "Kansas"));
    states.add(const CState(16, "KY", "U.S.", "Kentucky"));
    states.add(const CState(17, "LA", "U.S.", "Louisiana"));
    states.add(const CState(18, "ME", "U.S.", "Maine"));
    states.add(const CState(19, "MD", "U.S.", "Maryland"));
    states.add(const CState(20, "MA", "U.S.", "Massachusetts"));
    states.add(const CState(21, "MI", "U.S.", "Michigan"));
    states.add(const CState(22, "MN", "U.S.", "Minnesota"));
    states.add(const CState(23, "MS", "U.S.", "Mississippi"));
    states.add(const CState(24, "MO", "U.S.", "Missouri"));
    states.add(const CState(25, "MT", "U.S.", "Montana"));
    states.add(const CState(26, "NE", "U.S.", "Nebraska"));
    states.add(const CState(27, "NV", "U.S.", "Nevada"));
    states.add(const CState(28, "NH", "U.S.", "New Hampshire"));
    states.add(const CState(29, "NJ", "U.S.", "New Jersey"));
    states.add(const CState(30, "NM", "U.S.", "New Mexico"));
    states.add(const CState(31, "NY", "U.S.", "New York"));
    states.add(const CState(32, "NC", "U.S.", "North Carolina"));
    states.add(const CState(33, "ND", "U.S.", "North Dakota"));
    states.add(const CState(34, "OH", "U.S.", "Ohio"));
    states.add(const CState(35, "OK", "U.S.", "Oklahoma"));
    states.add(const CState(36, "OR", "U.S.", "Oregon"));
    states.add(const CState(37, "PA", "U.S.", "Pennsylvania"));
    states.add(const CState(38, "RI", "U.S.", "Rhode Island"));
    states.add(const CState(39, "SC", "U.S.", "South Carolina"));
    states.add(const CState(40, "SD", "U.S.", "South Dakota"));
    states.add(const CState(41, "TN", "U.S.", "Tennessee"));
    states.add(const CState(42, "TX", "U.S.", "Texas"));
    states.add(const CState(43, "UT", "U.S.", "Utah"));
    states.add(const CState(44, "VT", "U.S.", "Vermont"));
    states.add(const CState(45, "VA", "U.S.", "Virginia"));
    states.add(const CState(46, "WA", "U.S.", "Washington"));
    states.add(const CState(47, "WV", "U.S.", "West Virginia"));
    states.add(const CState(48, "WI", "U.S.", "Wisconsin"));
    states.add(const CState(49, "WY", "U.S.", "Wyoming"));
    states.add(const CState(61, "AB", "CA.", "Alberta"));
    states.add(const CState(62, "BC", "CA.", "British Columbia"));
    states.add(const CState(63, "MB", "CA.", "Manitoba"));
    states.add(const CState(64, "NB", "CA.", "New Brunswick"));
    states.add(const CState(72, "NL", "CA.", "Newfoundland and Labrador"));
    states.add(const CState(60, "NT", "CA.", "Northwest Territories"));
    states.add(const CState(65, "NS", "CA.", "Nova Scotia"));
    states.add(const CState(70, "NU", "CA.", "Nunavut"));
    states.add(const CState(67, "ON", "CA.", "Ontario"));
    states.add(const CState(66, "PE", "CA.", "Prince Edward Island"));
    states.add(const CState(68, "QC", "CA.", "Québec"));
    states.add(const CState(69, "SK", "CA.", "Saskatchewan"));
    states.add(const CState(71, "YT", "CA.", "Yukon"));
    return states;
  }
}
