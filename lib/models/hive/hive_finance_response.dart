import 'dart:convert';

import 'package:mobile_app/models/new_videos_feed/safe_convert.dart';

class HiveFinanceResponse {
  final int id;
  final String jsonrpc;
  final HiveFinanceResponseResult result;

  HiveFinanceResponse({
    this.id = 0,
    this.jsonrpc = "",
    required this.result,
  });

  factory HiveFinanceResponse.fromJson(Map<String, dynamic>? json) =>
      HiveFinanceResponse(
        id: asInt(json, 'id'),
        jsonrpc: asString(json, 'jsonrpc'),
        result: HiveFinanceResponseResult.fromJson(asMap(json, 'result')),
      );

  factory HiveFinanceResponse.fromJsonString(String jsonString) =>
      HiveFinanceResponse.fromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => {
        'id': id,
        'jsonrpc': jsonrpc,
        'result': result.toJson(),
      };
}

class HiveFinanceResponseResult {
  final int headBlockNumber;
  final String headBlockId;
  final String time;
  final String currentWitness;
  final int totalPow;
  final int numPowWitnesses;
  final String virtualSupply;
  final String currentSupply;
  final String initHbdSupply;
  final String currentHbdSupply;
  final String totalVestingFundHive;
  final String totalVestingShares;
  final String totalRewardFundHive;
  final String totalRewardShares2;
  final String pendingRewardedVestingShares;
  final String pendingRewardedVestingHive;
  final int hbdInterestRate;
  final int hbdPrintRate;
  final int maximumBlockSize;
  final int requiredActionsPartitionPercent;
  final int currentAslot;
  final String recentSlotsFilled;
  final int participationCount;
  final int lastIrreversibleBlockNum;
  final int votePowerReserveRate;
  final int delegationReturnPeriod;
  final int reverseAuctionSeconds;
  final int availableAccountSubsidies;
  final int hbdStopPercent;
  final int hbdStartPercent;
  final String nextMaintenanceTime;
  final String lastBudgetTime;
  final String nextDailyMaintenanceTime;
  final int contentRewardPercent;
  final int vestingRewardPercent;
  final int spsFundPercent;
  final String spsIntervalLedger;
  final int downvotePoolPercent;
  final int currentRemoveThreshold;
  final int earlyVotingSeconds;
  final int midVotingSeconds;
  final int maxConsecutiveRecurrentTransferFailures;
  final int maxRecurrentTransferEndDate;
  final int minRecurrentTransfersRecurrence;
  final int maxOpenRecurrentTransfers;

  double get totalVestingFundHiveDouble {
    return double.parse(totalVestingFundHive.replaceAll(' HIVE', ''));
  }

  double get totalVestingSharesDouble {
    return double.parse(totalVestingShares.replaceAll(' VESTS', ''));
  }

  HiveFinanceResponseResult({
    this.headBlockNumber = 0,
    this.headBlockId = "",
    this.time = "",
    this.currentWitness = "",
    this.totalPow = 0,
    this.numPowWitnesses = 0,
    this.virtualSupply = "",
    this.currentSupply = "",
    this.initHbdSupply = "",
    this.currentHbdSupply = "",
    this.totalVestingFundHive = "",
    this.totalVestingShares = "",
    this.totalRewardFundHive = "",
    this.totalRewardShares2 = "",
    this.pendingRewardedVestingShares = "",
    this.pendingRewardedVestingHive = "",
    this.hbdInterestRate = 0,
    this.hbdPrintRate = 0,
    this.maximumBlockSize = 0,
    this.requiredActionsPartitionPercent = 0,
    this.currentAslot = 0,
    this.recentSlotsFilled = "",
    this.participationCount = 0,
    this.lastIrreversibleBlockNum = 0,
    this.votePowerReserveRate = 0,
    this.delegationReturnPeriod = 0,
    this.reverseAuctionSeconds = 0,
    this.availableAccountSubsidies = 0,
    this.hbdStopPercent = 0,
    this.hbdStartPercent = 0,
    this.nextMaintenanceTime = "",
    this.lastBudgetTime = "",
    this.nextDailyMaintenanceTime = "",
    this.contentRewardPercent = 0,
    this.vestingRewardPercent = 0,
    this.spsFundPercent = 0,
    this.spsIntervalLedger = "",
    this.downvotePoolPercent = 0,
    this.currentRemoveThreshold = 0,
    this.earlyVotingSeconds = 0,
    this.midVotingSeconds = 0,
    this.maxConsecutiveRecurrentTransferFailures = 0,
    this.maxRecurrentTransferEndDate = 0,
    this.minRecurrentTransfersRecurrence = 0,
    this.maxOpenRecurrentTransfers = 0,
  });

  factory HiveFinanceResponseResult.fromJson(Map<String, dynamic>? json) =>
      HiveFinanceResponseResult(
        headBlockNumber: asInt(json, 'head_block_number'),
        headBlockId: asString(json, 'head_block_id'),
        time: asString(json, 'time'),
        currentWitness: asString(json, 'current_witness'),
        totalPow: asInt(json, 'total_pow'),
        numPowWitnesses: asInt(json, 'num_pow_witnesses'),
        virtualSupply: asString(json, 'virtual_supply'),
        currentSupply: asString(json, 'current_supply'),
        initHbdSupply: asString(json, 'init_hbd_supply'),
        currentHbdSupply: asString(json, 'current_hbd_supply'),
        totalVestingFundHive: asString(json, 'total_vesting_fund_hive'),
        totalVestingShares: asString(json, 'total_vesting_shares'),
        totalRewardFundHive: asString(json, 'total_reward_fund_hive'),
        totalRewardShares2: asString(json, 'total_reward_shares2'),
        pendingRewardedVestingShares:
            asString(json, 'pending_rewarded_vesting_shares'),
        pendingRewardedVestingHive:
            asString(json, 'pending_rewarded_vesting_hive'),
        hbdInterestRate: asInt(json, 'hbd_interest_rate'),
        hbdPrintRate: asInt(json, 'hbd_print_rate'),
        maximumBlockSize: asInt(json, 'maximum_block_size'),
        requiredActionsPartitionPercent:
            asInt(json, 'required_actions_partition_percent'),
        currentAslot: asInt(json, 'current_aslot'),
        recentSlotsFilled: asString(json, 'recent_slots_filled'),
        participationCount: asInt(json, 'participation_count'),
        lastIrreversibleBlockNum: asInt(json, 'last_irreversible_block_num'),
        votePowerReserveRate: asInt(json, 'vote_power_reserve_rate'),
        delegationReturnPeriod: asInt(json, 'delegation_return_period'),
        reverseAuctionSeconds: asInt(json, 'reverse_auction_seconds'),
        availableAccountSubsidies: asInt(json, 'available_account_subsidies'),
        hbdStopPercent: asInt(json, 'hbd_stop_percent'),
        hbdStartPercent: asInt(json, 'hbd_start_percent'),
        nextMaintenanceTime: asString(json, 'next_maintenance_time'),
        lastBudgetTime: asString(json, 'last_budget_time'),
        nextDailyMaintenanceTime: asString(json, 'next_daily_maintenance_time'),
        contentRewardPercent: asInt(json, 'content_reward_percent'),
        vestingRewardPercent: asInt(json, 'vesting_reward_percent'),
        spsFundPercent: asInt(json, 'sps_fund_percent'),
        spsIntervalLedger: asString(json, 'sps_interval_ledger'),
        downvotePoolPercent: asInt(json, 'downvote_pool_percent'),
        currentRemoveThreshold: asInt(json, 'current_remove_threshold'),
        earlyVotingSeconds: asInt(json, 'early_voting_seconds'),
        midVotingSeconds: asInt(json, 'mid_voting_seconds'),
        maxConsecutiveRecurrentTransferFailures:
            asInt(json, 'max_consecutive_recurrent_transfer_failures'),
        maxRecurrentTransferEndDate:
            asInt(json, 'max_recurrent_transfer_end_date'),
        minRecurrentTransfersRecurrence:
            asInt(json, 'min_recurrent_transfers_recurrence'),
        maxOpenRecurrentTransfers: asInt(json, 'max_open_recurrent_transfers'),
      );

  Map<String, dynamic> toJson() => {
        'head_block_number': headBlockNumber,
        'head_block_id': headBlockId,
        'time': time,
        'current_witness': currentWitness,
        'total_pow': totalPow,
        'num_pow_witnesses': numPowWitnesses,
        'virtual_supply': virtualSupply,
        'current_supply': currentSupply,
        'init_hbd_supply': initHbdSupply,
        'current_hbd_supply': currentHbdSupply,
        'total_vesting_fund_hive': totalVestingFundHive,
        'total_vesting_shares': totalVestingShares,
        'total_reward_fund_hive': totalRewardFundHive,
        'total_reward_shares2': totalRewardShares2,
        'pending_rewarded_vesting_shares': pendingRewardedVestingShares,
        'pending_rewarded_vesting_hive': pendingRewardedVestingHive,
        'hbd_interest_rate': hbdInterestRate,
        'hbd_print_rate': hbdPrintRate,
        'maximum_block_size': maximumBlockSize,
        'required_actions_partition_percent': requiredActionsPartitionPercent,
        'current_aslot': currentAslot,
        'recent_slots_filled': recentSlotsFilled,
        'participation_count': participationCount,
        'last_irreversible_block_num': lastIrreversibleBlockNum,
        'vote_power_reserve_rate': votePowerReserveRate,
        'delegation_return_period': delegationReturnPeriod,
        'reverse_auction_seconds': reverseAuctionSeconds,
        'available_account_subsidies': availableAccountSubsidies,
        'hbd_stop_percent': hbdStopPercent,
        'hbd_start_percent': hbdStartPercent,
        'next_maintenance_time': nextMaintenanceTime,
        'last_budget_time': lastBudgetTime,
        'next_daily_maintenance_time': nextDailyMaintenanceTime,
        'content_reward_percent': contentRewardPercent,
        'vesting_reward_percent': vestingRewardPercent,
        'sps_fund_percent': spsFundPercent,
        'sps_interval_ledger': spsIntervalLedger,
        'downvote_pool_percent': downvotePoolPercent,
        'current_remove_threshold': currentRemoveThreshold,
        'early_voting_seconds': earlyVotingSeconds,
        'mid_voting_seconds': midVotingSeconds,
        'max_consecutive_recurrent_transfer_failures':
            maxConsecutiveRecurrentTransferFailures,
        'max_recurrent_transfer_end_date': maxRecurrentTransferEndDate,
        'min_recurrent_transfers_recurrence': minRecurrentTransfersRecurrence,
        'max_open_recurrent_transfers': maxOpenRecurrentTransfers,
      };
}
