import 'package:cs492_weather_app/models/weather_forecast.dart';
import 'package:flutter/rendering.dart';
import '../../models/user_location.dart';
import 'package:flutter/material.dart';
import '../location/location.dart';

class WeatherScreen extends StatefulWidget {
  final Function getLocation;
  final Function getForecasts;
  final Function getForecastsHourly;
  final Function setLocation;

  const WeatherScreen(
      {super.key,
      required this.getLocation,
      required this.getForecasts,
      required this.getForecastsHourly,
      required this.setLocation});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

// class _WeatherScreenState extends State<WeatherScreen> {
//   bool hourly = true;
//   @override
//   Widget build(BuildContext context) {
//     return (widget.getLocation() != null && widget.getForecasts().isNotEmpty
//         ? SingleChildScrollView(
//           child: Column(
//             //mainAxisSize: FlexFit.loose,
//             children: [
//               TextButton(child: Text("swap"), onPressed: () => setState(() {
//                 hourly = !hourly;
//               })),
//               ForecastWidget(
//                   hourly: hourly,    //requires button
//                   context: context,
//                   location: widget.getLocation(),
//                   //forecasts: hourly? widget.getForecastsHourly() : widget.getForecasts()//turnary if/else
//                   forecasts: widget.getForecastsHourly()
//                   ),
//             ],
//           ),
//         ) 
//         : LocationWidget(widget: widget));
//   }
// }

class _WeatherScreenState extends State<WeatherScreen> {
  bool hourly = true;
  @override
  Widget build(BuildContext context) {
    return (widget.getLocation() != null && widget.getForecasts().isNotEmpty
        ? Center(
          child: ForecastWidget(
              hourly: hourly,
              context: context,
              location: widget.getLocation(),
              forecasts: widget.getForecastsHourly()),
        )
        : LocationWidget(widget: widget));
  }
}

class ForecastWidget extends StatelessWidget {
  final UserLocation location;
  final List<WeatherForecast> forecasts;
  final BuildContext context;
  final bool hourly;

  const ForecastWidget(
      {super.key,
      required this.hourly,
      required this.context,
      required this.location,
      required this.forecasts});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LocationTextWidget(location: location),
        ),
        if (hourly)
        HourlyForcastWidget(forecasts: forecasts),
        //DescriptionWidget(forecasts: forecasts)
    
      ],
    );
  }
}

// class DescriptionWidget extends StatelessWidget {
//   const DescriptionWidget({
//     super.key,
//     required this.forecasts,
//   });

//   final List<WeatherForecast> forecasts;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 25,
//       width: 500,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(child: Builder(builder: (context) {
//             if (forecasts.elementAt(0).shortForecast == "Sunny") {
//               return SizedBox(
//                   child: Image.asset('assets/images/Sun.png'),
//                   width: 50,
//                   height: 50);
//             } else {
//               return SizedBox(
//                   child: Image.asset('assets/images/Rain.png'),
//                   width: 50,
//                   height: 50);
//             }
//           })),
//           Center(
//               child: Text(forecasts.elementAt(0).shortForecast,
//                   style: Theme.of(context).textTheme.bodyMedium)),
//         ],
//       ),
//     );
//   }
// }

class HourlyForcastWidget extends StatelessWidget {
  const HourlyForcastWidget({
    super.key,
    required this.forecasts,
  });

  final List<WeatherForecast> forecasts;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, index) {
          return HourlyCardWidget(forecast: forecasts[index]);
        },
      ),
    );
  }
}

class HourlyCardWidget extends StatelessWidget {
  final WeatherForecast forecast;
  const HourlyCardWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('${forecast.temperature}º'),
      Text('${forecast.shortForecast}'),
      WeatherImageWidget(forecast: forecast)
    ]);
  }
}

class WeatherImageWidget extends StatelessWidget {
  final WeatherForecast forecast;
  const WeatherImageWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    if (forecast.shortForecast.contains("Sunny")){
      return SizedBox(
        child: Image.asset('assets/images/sun.png'), width: 50, height: 50);
    }
    if (forecast.shortForecast.contains("Clear")){
      return SizedBox(
        child: Image.asset('assets/images/clear.png'), width: 50, height: 50);
    }
    if (forecast.shortForecast.contains("Wind")){
      return SizedBox(
        child: Image.asset('assets/images/wind.png'), width: 50, height: 50);
    }
    if (forecast.shortForecast.contains("Rain")){
      return SizedBox(
        child: Image.asset('assets/images/rain.png'), width: 50, height: 50);
    }
    if (forecast.shortForecast.contains("Snow")){
      return SizedBox(
        child: Image.asset('assets/images/snowflake.png'), width: 50, height: 50);
    }
    else {
      return SizedBox(
                child: Image.asset('assets/images/weather.png'), width: 50, height: 50);
    }
  }
}

// child: Text('${forecasts.elementAt(0).temperature}º',
//             style: Theme.of(context).textTheme.displayLarge),

class LocationTextWidget extends StatelessWidget {
  const LocationTextWidget({
    super.key,
    required this.location,
  });

  final UserLocation location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 500,
        child: Center(
          child: Text("${location.city}, ${location.state}, ${location.zip}",
              style: Theme.of(context).textTheme.headlineSmall),
        ),
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.widget,
  });

  final WeatherScreen widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Requires a location to begin"),
          ),
          Location(
              setLocation: widget.setLocation, getLocation: widget.getLocation),
        ],
      ),
    );
  }
}
