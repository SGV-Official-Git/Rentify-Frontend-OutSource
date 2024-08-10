class ExpenseGraph {
  final List<Total>? totals;
  final int? totalSum;

  ExpenseGraph({
    this.totals,
    this.totalSum,
  });

  factory ExpenseGraph.fromJson(Map<String, dynamic> json) => ExpenseGraph(
        totals: json["totals"] == null
            ? []
            : List<Total>.from(json["totals"]!.map((x) => Total.fromJson(x))),
        totalSum: json["totalSum"],
      );

  Map<String, dynamic> toJson() => {
        "totals": totals == null
            ? []
            : List<dynamic>.from(totals!.map((x) => x.toJson())),
        "totalSum": totalSum,
      };
}

class Total {
  final String? period;
  final int? total;

  Total({
    this.period,
    this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        period: json["period"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "period": period,
        "total": total,
      };
}
