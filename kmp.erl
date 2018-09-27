%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 八月 2018 21:46
%%%-------------------------------------------------------------------
-module(kmp).
-author("Administrator").

%% API
-export([bad_finder/2]).
%-export([kmp_finder/2]).

bad_finder(ListTotal,ListKey) when is_list(ListKey),is_list(ListTotal)->
  TupleR=searcher(ListTotal,ListKey,1,[],length(ListTotal),length(ListKey)),
  io:format("~p~n",[TupleR]);
bad_finder(_,_)->
  io:format("wrong input").

%kmp_finder(ListTotal,ListKey)

searcher(_L1,_Lk,_N,_,_LengthL,_LengthK) when _LengthL<_LengthK->
  {not_started, not_found};
searcher(_,_Lk,_,_,_,_LengthK) when _LengthK==0->
  {empty_key};
searcher(L1,Lk,N,Res,LengthL,LengthK) when LengthL>=(N+LengthK-1)->
  case lists:nth(N,L1)==lists:nth(1,Lk) of
    true->
      case sub_check(L1,Lk,N+1,LengthK-1,LengthK) of
        {sub_check_found}->
          searcher(L1,Lk,N+1,Res++[N],LengthL,LengthK);
        _->
          searcher(L1,Lk,N+1,Res,LengthL,LengthK)
      end;
    _->
      searcher(L1,Lk,N+1,Res,LengthL,LengthK)
  end;
searcher(_L1,_Lk,_N,Res,_LengthL,_LengthK) when _LengthL<(_N+_LengthK-1)->
  {checked, Res};
searcher(_,_,_,_,_,_)->
  {bad_input}.

sub_check(L1,Lk,N,M,KeyLength) when M>0->
  case lists:nth(N,L1)==lists:nth((KeyLength+1-M),Lk) of
    true->
      %%io:format("compared"),
      sub_check(L1,Lk,N+1,M-1,KeyLength);
    _->
      {sub_check_not_found}
  end;
sub_check(_,_,_,M,_) when M==0->
  {sub_check_found}.

