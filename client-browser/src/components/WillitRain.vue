<template>
    <div>
        <div class="md-layout md-gutter">
            <div class="md-layout-item">
                <md-field>
                    <label for="country">Country</label>
                    <md-select name="country" id="country" v-model="selectedCountry" placeholder="Country">
                        <md-option v-bind:key="country.code" v-for="country in countries" :value="country.code">{{country.name}}</md-option>
                    </md-select>
                </md-field>
            </div>

            <div class="md-layout-item">
                <md-field>
                    <label for="station">Station</label>
                    <md-select v-model="selectedStation" name="station" id="station" placeholder="Station">
                        <md-option v-bind:key="station.id" v-for="station in stations" :value="station.id">{{station.name}}</md-option>
                    </md-select>
                </md-field>
            </div>
        </div>
        <div id="showMonthPicker" v-if="showMonthPicker">
            <md-radio v-bind:key="key" v-for="(value,key) in months" v-model="selectedMonth" :value="key">{{value}}</md-radio>
        </div>
        <div v-if="showChart" id="chart">
            <line-chart :chartData= "chartData"
                        :options="chartOptions"/>
        </div>
        <div class="md-elevation-10">
            <md-table>
                <md-table-toolbar class="md-primary">
                    <span class="md-title percentages-title">Data <em>(last 50 years)</em></span>
                </md-table-toolbar>
                <md-table-row>
                    <md-table-head md-numeric>Day of the month</md-table-head>
                    <md-table-head md-numeric>Years with rain</md-table-head>
                    <md-table-head md-numeric>Chance of rain</md-table-head>
                </md-table-row>

                <md-table-row v-bind:key="month.day" v-for="month in rainpercetageArray">
                    <md-table-cell md-numeric>{{month.day}}</md-table-cell >
                    <md-table-cell md-numeric>{{month.years_with_rain}}</md-table-cell >
                    <md-table-cell md-numeric>{{month.percentage}}</md-table-cell >
                </md-table-row>

            </md-table>
        </div>
        <div> <p class="diclaimer">Data source: <a href="https://www.ecad.eu">https://www.ecad.eu</a></p></div>
    </div>
</template>

<script>
    import LineChart from "@/components/LineChart";
    const months = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "Octomber",
      11: "November",
      12: "December"
    }
    export default {
      components: {LineChart},
      data: function () {
        return {
          selectedCountry: "",
          countries: [],
          selectedStation: null,
          stations: [],
          months: months,
          selectedMonth: "",
          showMonthPicker: false,
          rainpercetageArray: [],

          //Chart
          showChart: false,
          chartData: {},
          chartOptions: {
            responsive: true,
            maintainAspectRatio: false,
          }
        };
      },
        created() {
            this.getCountries();
        },
        watch: {
            selectedCountry: function () {
                this.selectedStation=null;
                this.showOrHideMonthPicker();
                this.getStations();
                this.rainpercetageArray = [];
            }
            ,selectedStation: function () {
                this.showOrHideMonthPicker();
                this.getPercentages();
            }
            ,selectedMonth: function () {
                this.getPercentages();
            }
        },
        methods: {
            getCountries() {
                var url = this.$serverHost+"/countries";
                this.$http.get(url).then(
                    response => {
                        this.countries = response.body;
                    });
            }
            , getStations() {
                var url = this.$serverHost+"/stations/" +this.selectedCountry;
                this.$http.get(url).then(
                    response => {
                        response.body.length > 1000 ? this.stations = response.body.slice(0, 1000) : this.stations = response.body;
                    });
            }
            , showOrHideMonthPicker() {
                if (this.selectedStation != null) {
                    this.showMonthPicker = true;
                } else {
                    this.showMonthPicker = false;
                    this.showChart = false;
                }
            }
            , getPercentages: function () {
                var url = this.$serverHost + "/rainpercentage?" +
                    "stationid=" + this.selectedStation +
                    "&month=" + this.selectedMonth
                if (!this.isEmpty(this.selectedMonth) && !this.isEmpty(this.selectedStation)) {
                    this.$http.get(url).then( response => this.updateData(response));

                }
            }
          , isEmpty(input) {
            return input==null || input==="";
          }
          , updateData(response) {
            let percentages = [];
            let years = [];
            let month = this.selectedMonth;
            this.rainpercetageArray = response.body;
            this.rainpercetageArray.forEach(function (x) {
              x.day = x.day + "/" + month;
              percentages.push(x.percentage);
              years.push(x.years_with_rain);
            });
            this.updateChart(percentages, years);
          }
          , updateChart(percentages ,years) {
            this.chartData = {
              labels: Array.from({length: this.rainpercetageArray.length}, (_, i) => i + 1 + "/" + this.selectedMonth), //create an array with values from 1 - 31,
              datasets: [
                {
                  label: 'Chance of rain',
                  backgroundColor: '#f87979',
                  data: percentages //will be populated dynamically
                },
                {
                  label: 'Years with rain',
                  backgroundColor: '#00ccff',
                  data: years //will be populated dynamically
                }
              ]
            }
            this.showChart = true;
          }
        }
    };


</script>

<style scoped>
    .percentages-title {
        text-align: center;
    }
    .diclaimer {
        margin-top: 20px;
    }
</style>
