<template>
    <div>
        <div class="md-layout md-gutter">
            <div class="md-layout-item">
                <md-field>
                    <md-select name="country" id="country" v-model="selectedCountry" placeholder="Country">
                        <md-option v-bind:key="country.code" v-for="country in countries" :value="country.code">{{country.name}}</md-option>
                    </md-select>
                </md-field>
            </div>

            <div class="md-layout-item">
                <md-field>
                    <md-select v-model="selectedStation" name="station" id="station" placeholder="Station">
                        <md-option v-bind:key="station.id" v-for="station in stations" :value="station.id">{{station.name}}</md-option>
                    </md-select>
                </md-field>
            </div>
        </div>
        <div class="showMonthPicker" v-if="showMonthPicker">
            <md-radio v-bind:key="key" v-for="(value,key) in months" v-model="selectedMonth" :value="key">{{value}}</md-radio>
        </div>
        <div class="md-elevation-10">
            <md-table>
                <md-table-toolbar class="md-primary">
                    <span class="md-title percentages-title">Percentages</span>
                </md-table-toolbar>
                <md-table-row>
                    <md-table-head md-numeric>Day of the month</md-table-head>
                    <md-table-head md-numeric>Years with rain</md-table-head>
                    <md-table-head md-numeric>Percentage for rain</md-table-head>
                </md-table-row>

                <md-table-row v-bind:key="month.day" v-for="month in rainpercetageArray">
                    <md-table-cell md-numeric>{{month.day}}</md-table-cell >
                    <md-table-cell md-numeric>{{month.years_with_rain}}</md-table-cell >
                    <md-table-cell md-numeric>{{month.percentage}}</md-table-cell >
                </md-table-row>

            </md-table>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                selectedCountry: "",
                countries: [],
                selectedStation: null,
                stations: [],
                months: {1:"January",2:"February",3:"March",4:"April",5:"May",6:"June",7:"July",8:"August",9:"September",
                    10:"Octomber",11:"November",12:"December"},
                selectedMonth: "",
                showMonthPicker: false,
                rainpercetageArray: []
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
                        this.stations = response.body;
                    });
            }
            , showOrHideMonthPicker() {
                if (this.selectedStation != null) {
                    this.showMonthPicker = true;
                } else {
                    this.showMonthPicker = false;
                }
            }
            , getPercentages() {
                var url = this.$serverHost+"/rainpercentage?" +
                    "stationid="+this.selectedStation+
                    "&month="+this.selectedMonth
                this.$http.get(url).then(
                    response => {
                        this.rainpercetageArray = response.body;
                    });
            }
        }
    };
</script>

<style scoped>
    .home-panel {
        vertical-align: center;
        font-size: 20px;
        margin: 15px;
    }

    .md-table-cell.md-numeric {
        text-align: center;
    }

    .md-table-head.md-numeric {
        text-align: center;
    }

    .description-label {
        margin-bottom: 15px;
    }

    .percentages-title {
        text-align: center;
    }
</style>